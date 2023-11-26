Return-Path: <linux-serial+bounces-229-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D9B7F920C
	for <lists+linux-serial@lfdr.de>; Sun, 26 Nov 2023 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D9E1F2091B
	for <lists+linux-serial@lfdr.de>; Sun, 26 Nov 2023 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101DF6AB6;
	Sun, 26 Nov 2023 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014DD9
	for <linux-serial@vger.kernel.org>; Sun, 26 Nov 2023 01:53:25 -0800 (PST)
Received: from [IPV6:2a02:8109:a893:3b00:7bad:dd01:344c:715f] (unknown [IPv6:2a02:8109:a893:3b00:7bad:dd01:344c:715f])
	by mail.someserver.de (Postfix) with ESMTPSA id 80633A219E;
	Sun, 26 Nov 2023 10:53:19 +0100 (CET)
Message-ID: <0fb134f7-f72e-4742-9c2d-c68f83b67975@christina-quast.de>
Date: Sun, 26 Nov 2023 10:53:18 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] hid-ft260: Add serial driver
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Daniel Beer
 <daniel.beer@igorinstitute.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231122094004.95399-1-contact@christina-quast.de>
 <2023112205-explore-frequency-40a6@gregkh>
From: Christina Quast <contact@christina-quast.de>
In-Reply-To: <2023112205-explore-frequency-40a6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg!

Thanks for the comments!

On 11/22/23 11:15, Greg KH wrote:
> On Wed, Nov 22, 2023 at 10:40:03AM +0100, Christina Quast wrote:
>> This commit adds a serial interface /dev/FTx which implements the tty
>> serial driver ops, so that it is possible to set the baudrate, send
>> and receive data, etc.
> Why is this a serial device?  What type of device is it?
>
> And why "FTx"?  Where did that name come from?  That's not a "normal"
> tty name.
I meant /dev/ttyFTx. Since it's a hid device providing a serial 
interface, in theory you could also call it /dev/ttySx or /dev/ttyUSBx, 
but both feel wrong. It's an FTDI device, that functions as a USB to 
UART / I2C Master. Do you have a better name in mind?
>> --- a/drivers/hid/hid-ft260.c
>> +++ b/drivers/hid/hid-ft260.c
>> @@ -13,6 +13,16 @@
>>   #include <linux/i2c.h>
>>   #include <linux/module.h>
>>   #include <linux/usb.h>
>> +#include <linux/serial.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/kfifo.h>
>> +#include <linux/tty_flip.h>
>> +#include <linux/minmax.h>
>> +#include <asm-generic/unaligned.h>
> Why is unaligned.h needed here?
>
>> +
>> +#define UART_COUNT_MAX		4	/* Number of UARTs this driver can handle */
>> +#define FIFO_SIZE	256
>> +#define TTY_WAKEUP_WATERMARK	(FIFO_SIZE / 2)
>>   
>>   #ifdef DEBUG
>>   static int ft260_debug = 1;
>> @@ -30,6 +40,7 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
>>   
>>   #define FT260_REPORT_MAX_LENGTH (64)
>>   #define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
>> +#define FT260_UART_DATA_REPORT_ID(len) (FT260_UART_REPORT_MIN + (len - 1) / 4)
>>   
>>   #define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
>>   
>> @@ -81,7 +92,8 @@ enum {
>>   	FT260_UART_INTERRUPT_STATUS	= 0xB1,
>>   	FT260_UART_STATUS		= 0xE0,
>>   	FT260_UART_RI_DCD_STATUS	= 0xE1,
>> -	FT260_UART_REPORT		= 0xF0,
>> +	FT260_UART_REPORT_MIN		= 0xF0,
>> +	FT260_UART_REPORT_MAX		= 0xFE,
>>   };
>>   
>>   /* Feature Out */
>> @@ -132,6 +144,13 @@ enum {
>>   	FT260_FLAG_START_STOP_REPEATED	= 0x07,
>>   };
>>   
>> +/* Return values for ft260_get_interface_type func */
>> +enum {
>> +	FT260_IFACE_NONE,
>> +	FT260_IFACE_I2C,
>> +	FT260_IFACE_UART
>> +};
>> +
>>   #define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | report_id)
>>   
>>   /* Feature In reports */
>> @@ -220,12 +239,59 @@ struct ft260_i2c_read_request_report {
>>   	__le16 length;		/* data payload length */
>>   } __packed;
>>   
>> -struct ft260_i2c_input_report {
>> -	u8 report;		/* FT260_I2C_REPORT */
>> +struct ft260_input_report {
>> +	u8 report;		/* FT260_I2C_REPORT or FT260_UART_REPORT */
>>   	u8 length;		/* data payload length */
>>   	u8 data[2];		/* data payload */
>>   } __packed;
>>   
>> +/* UART reports */
>> +struct ft260_uart_write_request_report {
>> +	u8 report;		/* FT260_UART_REPORT */
>> +	u8 length;		/* data payload length */
>> +	u8 data[];		/* data payload */
> Shouldn't this be marked as counted by length?
Do you mean in the comment?
>
>
>> +} __packed;
>> +
>> +struct ft260_configure_uart_request {
>> +	u8 report;		/* FT260_SYSTEM_SETTINGS */
>> +	u8 request;		/* FT260_SET_UART_CONFIG */
>> +	u8 flow_ctrl;		/* 0: OFF, 1: RTS_CTS, 2: DTR_DSR */
>> +				/* 3: XON_XOFF, 4: No flow ctrl */
>> +	/* The baudrate field is unaligned: */
>> +	__le32 baudrate;	/* little endian, 9600 = 0x2580, 19200 = 0x4B00 */
>> +	u8 data_bit;		/* 7 or 8 */
>> +	u8 parity;		/* 0: no parity, 1: odd, 2: even, 3: high, 4: low */
>> +	u8 stop_bit;		/* 0: one stop bit, 2: 2 stop bits */
>> +	u8 breaking;		/* 0: no break */
>> +} __packed;
>> +
>> +/* UART interface configuration */
>> +enum {
>> +	FT260_CFG_FLOW_CTRL_OFF		= 0x00,
>> +	FT260_CFG_FLOW_CTRL_RTS_CTS	= 0x01,
>> +	FT260_CFG_FLOW_CTRL_DTR_DSR	= 0x02,
>> +	FT260_CFG_FLOW_CTRL_XON_XOFF	= 0x03,
>> +	FT260_CFG_FLOW_CTRL_NONE	= 0x04,
>> +
>> +	FT260_CFG_DATA_BITS_7		= 0x07,
>> +	FT260_CFG_DATA_BITS_8		= 0x08,
>> +
>> +	FT260_CFG_PAR_NO		= 0x00,
>> +	FT260_CFG_PAR_ODD		= 0x01,
>> +	FT260_CFG_PAR_EVEN		= 0x02,
>> +	FT260_CFG_PAR_HIGH		= 0x03,
>> +	FT260_CFG_PAR_LOW		= 0x04,
>> +
>> +	FT260_CFG_STOP_ONE_BIT		= 0x00,
>> +	FT260_CFG_STOP_TWO_BIT		= 0x02,
>> +
>> +	FT260_CFG_BREAKING_NO		= 0x00,
>> +	FT260_CFG_BEAKING_YES		= 0x01,
>> +
>> +	FT260_CFG_BAUD_MIN		= 1200,
>> +	FT260_CFG_BAUD_MAX		= 12000000,
>> +};
>> +
>>   static const struct hid_device_id ft260_devices[] = {
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
>>   			 USB_DEVICE_ID_FT260) },
>> @@ -236,6 +302,18 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
>>   struct ft260_device {
>>   	struct i2c_adapter adap;
>>   	struct hid_device *hdev;
>> +
>> +	int ft260_is_serial;
> bool?
>
>> +	struct tty_port port;
> port has lifetime rules, are you sure it's ok to embed here?
>
>> +	unsigned int index;
>> +	struct kfifo xmit_fifo;
>> +	/* write_lock: lock to serialize access to xmit fifo */
>> +	spinlock_t write_lock;
>> +	struct uart_icount icount;
>> +
>> +	struct timer_list wakeup_timer;
>> +	struct work_struct wakeup_work;
>> +
>>   	struct completion wait;
>>   	struct mutex lock;
>>   	u8 write_buf[FT260_REPORT_MAX_LENGTH];
>> @@ -782,7 +860,7 @@ static int ft260_get_system_config(struct hid_device *hdev,
>>   	return 0;
>>   }
>>   
>> -static int ft260_is_interface_enabled(struct hid_device *hdev)
>> +static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device *dev)
>>   {
>>   	struct ft260_get_system_status_report cfg;
>>   	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
>> @@ -802,18 +880,22 @@ static int ft260_is_interface_enabled(struct hid_device *hdev)
>>   	switch (cfg.chip_mode) {
>>   	case FT260_MODE_ALL:
>>   	case FT260_MODE_BOTH:
>> -		if (interface == 1)
>> -			hid_info(hdev, "uart interface is not supported\n");
>> -		else
>> -			ret = 1;
>> +		if (interface == 1) {
>> +			ret = FT260_IFACE_UART;
>> +			dev->ft260_is_serial = 1;
>> +		} else {
>> +			ret = FT260_IFACE_I2C;
>> +		}
>>   		break;
>>   	case FT260_MODE_UART:
>> -		hid_info(hdev, "uart interface is not supported\n");
>> +		ret = FT260_IFACE_UART;
>> +		dev->ft260_is_serial = 1;
>>   		break;
>>   	case FT260_MODE_I2C:
>> -		ret = 1;
>> +		ret = FT260_IFACE_I2C;
>>   		break;
>>   	}
>> +
>>   	return ret;
>>   }
>>   
>> @@ -957,51 +1039,401 @@ static const struct attribute_group ft260_attr_group = {
>>   	}
>>   };
>>   
>> -static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
>> +/***
>> + * START Serial dev part
>> + */
>> +static struct ft260_device *ft260_uart_table[UART_COUNT_MAX];
>> +static DEFINE_SPINLOCK(ft260_uart_table_lock);
> Is this static array still needed?  Shouldn't this be a per-device thing?
>
>> +
>> +static int ft260_uart_add_port(struct ft260_device *port)
>>   {
>> -	struct ft260_device *dev;
>> -	struct ft260_get_chip_version_report version;
>> -	int ret;
>> +	int index, ret = -EBUSY;
>>   
>> -	if (!hid_is_usb(hdev))
>> -		return -EINVAL;
>> -
>> -	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
>> -	if (!dev)
>> +	spin_lock_init(&port->write_lock);
>> +	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
>>   		return -ENOMEM;
>>   
>> -	ret = hid_parse(hdev);
>> -	if (ret) {
>> -		hid_err(hdev, "failed to parse HID\n");
>> -		return ret;
>> +	spin_lock(&ft260_uart_table_lock);
>> +	for (index = 0; index < UART_COUNT_MAX; index++) {
>> +		if (!ft260_uart_table[index]) {
>> +			port->index = index;
>> +			ft260_uart_table[index] = port;
>> +			ret = 0;
>> +			break;
>> +		}
>>   	}
>> +	spin_unlock(&ft260_uart_table_lock);
>>   
>> -	ret = hid_hw_start(hdev, 0);
>> -	if (ret) {
>> -		hid_err(hdev, "failed to start HID HW\n");
>> -		return ret;
>> +	return ret;
>> +}
>> +
>> +static void ft260_uart_port_put(struct ft260_device *port)
>> +{
>> +	tty_port_put(&port->port);
>> +}
>> +
>> +static void ft260_uart_port_remove(struct ft260_device *port)
>> +{
>> +	spin_lock(&ft260_uart_table_lock);
>> +	ft260_uart_table[port->index] = NULL;
>> +	spin_unlock(&ft260_uart_table_lock);
>> +
>> +	mutex_lock(&port->port.mutex);
>> +	/* tty_hangup is async so is this safe as is ?? */
> What is "??" for?
>
>> +	tty_port_tty_hangup(&port->port, false);
>> +	mutex_unlock(&port->port.mutex);
>> +
>> +	ft260_uart_port_put(port);
>> +}
>> +
>> +static struct ft260_device *ft260_uart_port_get(unsigned int index)
>> +{
>> +	struct ft260_device *port;
>> +
>> +	if (index >= UART_COUNT_MAX)
>> +		return NULL;
>> +
>> +	spin_lock(&ft260_uart_table_lock);
>> +	port = ft260_uart_table[index];
>> +	if (port)
>> +		tty_port_get(&port->port);
>> +	spin_unlock(&ft260_uart_table_lock);
>> +
>> +	return port;
>> +}
>> +
>> +static int ft260_uart_open(struct tty_struct *tty, struct file *filp)
>> +{
>> +	int ret;
>> +	struct ft260_device *port = tty->driver_data;
>> +
>> +	ret = tty_port_open(&port->port, tty, filp);
>> +
>> +	return ret;
>> +}
>> +
>> +static void ft260_uart_close(struct tty_struct *tty, struct file *filp)
>> +{
>> +	struct ft260_device *port = tty->driver_data;
>> +
>> +	tty_port_close(&port->port, tty, filp);
>> +}
>> +
>> +static void ft260_uart_hangup(struct tty_struct *tty)
>> +{
>> +	struct ft260_device *port = tty->driver_data;
>> +
>> +	tty_port_hangup(&port->port);
>> +}
>> +
>> +static int ft260_uart_transmit_chars(struct ft260_device *port)
>> +{
>> +	struct hid_device *hdev = port->hdev;
>> +	struct kfifo *xmit = &port->xmit_fifo;
>> +	struct tty_struct *tty;
>> +	struct ft260_uart_write_request_report *rep;
>> +	int len, data_len, ret = 0;
>> +
>> +	tty = tty_port_tty_get(&port->port);
>> +
>> +	data_len = kfifo_len(xmit);
>> +	if (!tty || !data_len) {
>> +		ret = -EINVAL;
>> +		goto tty_out;
>>   	}
>>   
>> -	ret = hid_hw_open(hdev);
>> -	if (ret) {
>> -		hid_err(hdev, "failed to open HID HW\n");
>> -		goto err_hid_stop;
>> +	rep = (struct ft260_uart_write_request_report *)port->write_buf;
>> +
>> +	do {
>> +		len = min(data_len, FT260_WR_DATA_MAX);
>> +
>> +		rep->report = FT260_UART_DATA_REPORT_ID(len);
>> +		rep->length = len;
>> +
>> +		len = kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
>> +
>> +		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
>> +		if (ret < 0) {
>> +			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
>> +			goto tty_out;
>> +		}
>> +
>> +		data_len -= len;
>> +		port->icount.tx += len;
>> +	} while (data_len > 0);
>> +
>> +	len = kfifo_len(xmit);
>> +	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
>> +		tty_wakeup(tty);
>> +
>> +	ret = 0;
>> +
>> +tty_out:
>> +	tty_kref_put(tty);
>> +	return ret;
>> +}
>> +
>> +static int ft260_uart_receive_chars(struct ft260_device *port,
>> +				    u8 *data, u8 length)
>> +{
>> +	struct hid_device *hdev = port->hdev;
>> +	int ret = 0;
>> +
>> +	if (length > FT260_RD_DATA_MAX) {
>> +		hid_err(hdev, "Received too much data (%d)\n", length);
>> +		return -EBADR;
>>   	}
>>   
>> -	ret = ft260_hid_feature_report_get(hdev, FT260_CHIP_VERSION,
>> -					   (u8 *)&version, sizeof(version));
>> +	ret = tty_insert_flip_string(&port->port, data, length);
>> +	if (ret != length)
>> +		hid_err(hdev, "%d char not inserted to flip buffer\n", length - ret);
>> +	port->icount.rx += ret;
>> +
>> +	if (ret)
>> +		tty_flip_buffer_push(&port->port);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t ft260_uart_write(struct tty_struct *tty, const unsigned char *buf,
>> +			     size_t count)
>> +{
>> +	struct ft260_device *port = tty->driver_data;
>> +	struct hid_device *hdev = port->hdev;
>> +	int ret;
>> +
>> +	ret = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
>> +	if (ft260_uart_transmit_chars(port) != kfifo_len(&port->xmit_fifo))
>> +		hid_err(hdev, "Failed sending all kfifo data bytes\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static unsigned int ft260_uart_write_room(struct tty_struct *tty)
>> +{
>> +	struct ft260_device *port = tty->driver_data;
>> +
>> +	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
>> +}
>> +
>> +static unsigned int ft260_uart_chars_in_buffer(struct tty_struct *tty)
>> +{
>> +	struct ft260_device *port = tty->driver_data;
>> +
>> +	return kfifo_len(&port->xmit_fifo);
>> +}
>> +
>> +static int ft260_uart_change_speed(struct ft260_device *port,
>> +				   struct ktermios *termios,
>> +				    struct ktermios *old)
> Odd alignment, did you run this through checkpatch.pl?
>
>
>> +{
>> +	struct hid_device *hdev = port->hdev;
>> +	unsigned int baud;
>> +	struct ft260_configure_uart_request req;
>> +	int ret;
>> +
>> +	memset(&req, 0, sizeof(req));
>> +
>> +	req.report = FT260_SYSTEM_SETTINGS;
>> +	req.request = FT260_SET_UART_CONFIG;
>> +
>> +	switch (termios->c_cflag & CSIZE) {
>> +	case CS7:
>> +		req.data_bit = FT260_CFG_DATA_BITS_7;
>> +		break;
>> +	case CS5:
>> +	case CS6:
>> +		hid_err(hdev, "Invalid data bit size, setting to default (8 bit)\n");
> Don't let userspace spam the kernel log by sending it bad data.  That is
> a denial-of-service.
>
>> +		req.data_bit = FT260_CFG_DATA_BITS_8;
>> +		termios->c_cflag &= ~CSIZE;
>> +		termios->c_cflag |= CS8;
>> +		break;
>> +	default:
>> +	case CS8:
>> +		req.data_bit = FT260_CFG_DATA_BITS_8;
>> +		break;
>> +	}
>> +
>> +	req.stop_bit = (termios->c_cflag & CSTOPB) ?
>> +		FT260_CFG_STOP_TWO_BIT : FT260_CFG_STOP_ONE_BIT;
>> +
>> +	if (termios->c_cflag & PARENB) {
>> +		req.parity = (termios->c_cflag & PARODD) ?
>> +			FT260_CFG_PAR_ODD : FT260_CFG_PAR_EVEN;
>> +	} else {
>> +		req.parity = FT260_CFG_PAR_NO;
>> +	}
>> +
>> +	baud = tty_termios_baud_rate(termios);
>> +	if (baud == 0 || baud < FT260_CFG_BAUD_MIN || baud > FT260_CFG_BAUD_MAX) {
>> +		struct tty_struct *tty = tty_port_tty_get(&port->port);
> Blank line needed here.
>
>> +		hid_err(hdev, "Invalid baud rate %d\n", baud);
> Again, debug error?  And why not report an error instead of just setting
> it to 9600?
>
> And why 9600?

This is a default setting used in the FT260 documentation as default 
value, so it seemed like a sensible value.

The ft260_uart_change_speed function is called in set_termios, which has 
a void return type. So even if I returned an error, that would not be 
propagated to userspace. It looks like the userspace is meant to check 
what values were actually set with a subsequent ioctl call.

>
>> +		baud = 9600;
>> +		tty_encode_baud_rate(tty, baud, baud);
>> +		tty_kref_put(tty);
>> +	}
>> +	put_unaligned_le32(cpu_to_le32(baud), &req.baudrate);
>> +
>> +	if (termios->c_cflag & CRTSCTS)
>> +		req.flow_ctrl = FT260_CFG_FLOW_CTRL_RTS_CTS;
>> +	else
>> +		req.flow_ctrl = FT260_CFG_FLOW_CTRL_OFF;
>> +
>> +	ft260_dbg("Configured termios: flow control: %d, baudrate: %d, ",
>> +		  req.flow_ctrl, baud);
>> +	ft260_dbg("data_bit: %d, parity: %d, stop_bit: %d, breaking: %d\n",
>> +		  req.data_bit, req.parity,
>> +		  req.stop_bit, req.breaking);
>> +
>> +	req.flow_ctrl = FT260_CFG_FLOW_CTRL_NONE;
>> +	req.breaking = FT260_CFG_BREAKING_NO;
>> +
>> +	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
>>   	if (ret < 0) {
>> -		hid_err(hdev, "failed to retrieve chip version\n");
>> -		goto err_hid_close;
>> +		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
>>   	}
>>   
>> -	hid_info(hdev, "chip code: %02x%02x %02x%02x\n",
>> -		 version.chip_code[0], version.chip_code[1],
>> -		 version.chip_code[2], version.chip_code[3]);
>> +	return ret;
>> +}
>>   
>> -	ret = ft260_is_interface_enabled(hdev);
>> -	if (ret <= 0)
>> -		goto err_hid_close;
>> +static void ft260_uart_set_termios(struct tty_struct *tty,
>> +				   const struct ktermios *old_termios)
>> +{
>> +	struct ft260_device *port = tty->driver_data;
>> +
>> +	ft260_uart_change_speed(port, &tty->termios, NULL);
>> +}
>> +
>> +static int ft260_uart_install(struct tty_driver *driver, struct tty_struct *tty)
>> +{
>> +	int idx = tty->index;
>> +	struct ft260_device *port = ft260_uart_port_get(idx);
>> +	int ret = tty_standard_install(driver, tty);
>> +
>> +	if (ret == 0)
>> +		/* This is the ref ft260_uart_port get provided */
>> +		tty->driver_data = port;
>> +	else
>> +		ft260_uart_port_put(port);
>> +
>> +	return ret;
>> +}
>> +
>> +static void ft260_uart_cleanup(struct tty_struct *tty)
>> +{
>> +	struct ft260_device *port = tty->driver_data;
>> +
>> +	tty->driver_data = NULL;	/* Bug trap */
>> +	ft260_uart_port_put(port);
>> +}
>> +
>> +static int ft260_uart_proc_show(struct seq_file *m, void *v)
>> +{
>> +	return -EINVAL;
> Is this needed?
>
>> +}
>> +
>> +static const struct tty_operations ft260_uart_ops = {
>> +	.open			= ft260_uart_open,
>> +	.close			= ft260_uart_close,
>> +	.write			= ft260_uart_write,
>> +	.write_room		= ft260_uart_write_room,
>> +	.chars_in_buffer	= ft260_uart_chars_in_buffer,
>> +	.set_termios		= ft260_uart_set_termios,
>> +	.hangup			= ft260_uart_hangup,
>> +	.install		= ft260_uart_install,
>> +	.cleanup		= ft260_uart_cleanup,
>> +	.proc_show		= ft260_uart_proc_show,
>> +};
>> +
>> +static void uart_dtr_rts(struct tty_port *tport, bool onoff)
>> +{
>> +}
>> +
>> +static bool uart_carrier_raised(struct tty_port *tport)
>> +{
>> +	return -EINVAL;
>> +}
> Empty functions like this are probably not needed, right?  If so, let's
> fix the tty core to not need that to happen.
>
>> +
>> +/* The FT260 has a "power saving mode" that causes the device to switch
>> + * to a 30 kHz oscillator if there's no activity for 5 seconds.
>> + * Unfortunately this mode can only be disabled by reprogramming
>> + * internal fuses, which requires an additional programming voltage.
>> + *
>> + * One effect of this mode is to cause data loss on a fast UART that
>> + * transmits after being idle for longer than 5 seconds. We work around
>> + * this by sending a dummy report at least once per 4 seconds if the
>> + * UART is in use.
>> + */
>> +static void ft260_uart_start_wakeup(struct timer_list *t)
>> +{
>> +	struct ft260_device *dev =
>> +	       container_of(t, struct ft260_device, wakeup_timer);
>> +
>> +	schedule_work(&dev->wakeup_work);
>> +	mod_timer(&dev->wakeup_timer, jiffies +
>> +	       msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
>> +}
>> +
>> +static void ft260_uart_do_wakeup(struct work_struct *work)
>> +{
>> +	struct ft260_device *dev =
>> +	       container_of(work, struct ft260_device, wakeup_work);
>> +	struct ft260_get_chip_version_report version;
>> +	int ret;
>> +
>> +	ret = ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
>> +					  (u8 *)&version, sizeof(version));
>> +	if (ret < 0)
>> +	       hid_err(dev->hdev,
>> +		       "%s: failed to start transfer, ret %d\n",
>> +		       __func__, ret);
>> +}
>> +
>> +static void ft260_uart_shutdown(struct tty_port *tport)
>> +{
>> +	struct ft260_device *port =
>> +		container_of(tport, struct ft260_device, port);
>> +
>> +	del_timer_sync(&port->wakeup_timer);
>> +}
>> +
>> +static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
>> +{
>> +	struct ft260_device *port =
>> +		container_of(tport, struct ft260_device, port);
>> +
>> +	/*
>> +	 * Set the TTY IO error marker - we will only clear this
>> +	 * once we have successfully opened the port.
>> +	 */
>> +	set_bit(TTY_IO_ERROR, &tty->flags);
>> +	kfifo_reset(&port->xmit_fifo);
>> +	ft260_uart_change_speed(port, &tty->termios, NULL);
>> +	clear_bit(TTY_IO_ERROR, &tty->flags);
>> +
>> +	mod_timer(&port->wakeup_timer, jiffies +
>> +		  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
>> +
>> +	return 0;
>> +}
>> +
>> +static void ft260_uart_port_destroy(struct tty_port *tport)
>> +{
>> +}
>> +
>> +static const struct tty_port_operations ft260_uart_port_ops = {
>> +	.dtr_rts = uart_dtr_rts,
>> +	.carrier_raised = uart_carrier_raised,
>> +	.shutdown = ft260_uart_shutdown,
>> +	.activate = ft260_uart_activate,
>> +	.destruct = ft260_uart_port_destroy,
>> +};
>> +
>> +static struct tty_driver *ft260_tty_driver;
>> +
>> +static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
>> +{
>> +	int ret;
>>   
>>   	hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n",
>>   		hdev->version >> 8, hdev->version & 0xff, hdev->name,
>> @@ -1028,7 +1460,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>   	ret = i2c_add_adapter(&dev->adap);
>>   	if (ret) {
>>   		hid_err(hdev, "failed to add i2c adapter\n");
>> -		goto err_hid_close;
>> +		return ret;
>>   	}
>>   
>>   	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
>> @@ -1036,11 +1468,132 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>   		hid_err(hdev, "failed to create sysfs attrs\n");
>>   		goto err_i2c_free;
>>   	}
>> -
>>   	return 0;
>>   
>>   err_i2c_free:
>>   	i2c_del_adapter(&dev->adap);
>> +	return ret;
>> +}
>> +
>> +static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
>> +{
>> +	struct ft260_configure_uart_request req;
>> +	int ret;
>> +	struct device *devt;
>> +
>> +	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
>> +	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
>> +
>> +	tty_port_init(&dev->port);
>> +	dev->port.ops = &ft260_uart_port_ops;
>> +
>> +	ret = ft260_uart_add_port(dev);
>> +	if (ret) {
>> +		hid_err(hdev, "failed to add port\n");
>> +		return ret;
>> +	}
>> +	devt = tty_port_register_device_attr(&dev->port,
>> +					     ft260_tty_driver,
>> +					     dev->index, &hdev->dev,
>> +					     dev, NULL);
>> +	if (IS_ERR(devt)) {
>> +		hid_err(hdev, "failed to register tty port\n");
>> +		ret = PTR_ERR(devt);
>> +		goto err_register_tty;
>> +	}
>> +	hid_info(hdev, "Registering device /dev/%s%d\n",
>> +		ft260_tty_driver->name, dev->index);
> When drivers are working properly, they are quiet.  Please remove this
> log spam from the driver.
>
>
>> +
>> +	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
>> +	req.report	= FT260_SYSTEM_SETTINGS;
>> +	req.request	= FT260_SET_UART_CONFIG;
>> +	req.flow_ctrl	= FT260_CFG_FLOW_CTRL_NONE;
>> +	put_unaligned_le32(cpu_to_le32(9600), &req.baudrate);
>> +	req.data_bit	= FT260_CFG_DATA_BITS_8;
>> +	req.parity	= FT260_CFG_PAR_NO;
>> +	req.stop_bit	= FT260_CFG_STOP_ONE_BIT;
>> +	req.breaking	= FT260_CFG_BREAKING_NO;
>> +
>> +	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
>> +	if (ret < 0) {
>> +		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
>> +			ret);
>> +		goto err_hid_report;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_hid_report:
>> +	tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index);
>> +err_register_tty:
>> +	ft260_uart_port_remove(dev);
>> +	return ret;
>> +}
>> +
>> +static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
>> +{
>> +	struct ft260_device *dev;
>> +	struct ft260_get_chip_version_report version;
>> +	int ret;
>> +
>> +	if (!hid_is_usb(hdev))
>> +		return -EINVAL;
>> +
>> +	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
>> +	if (!dev)
>> +		return -ENOMEM;
>> +
>> +	ret = hid_parse(hdev);
>> +	if (ret) {
>> +		hid_err(hdev, "failed to parse HID\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = hid_hw_start(hdev, 0);
>> +	if (ret) {
>> +		hid_err(hdev, "failed to start HID HW\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = hid_hw_open(hdev);
>> +	if (ret) {
>> +		hid_err(hdev, "failed to open HID HW\n");
>> +		goto err_hid_stop;
>> +	}
>> +
>> +	ret = ft260_hid_feature_report_get(hdev, FT260_CHIP_VERSION,
>> +					   (u8 *)&version, sizeof(version));
>> +	if (ret < 0) {
>> +		hid_err(hdev, "failed to retrieve chip version\n");
>> +		goto err_hid_close;
>> +	}
>> +
>> +	hid_info(hdev, "chip code: %02x%02x %02x%02x\n",
>> +		 version.chip_code[0], version.chip_code[1],
>> +		 version.chip_code[2], version.chip_code[3]);
> Again, not needed, make this a debugging message if you really want to
> see it.
>
>> +
>> +	ret = ft260_get_interface_type(hdev, dev);
>> +	if (ret <= FT260_IFACE_NONE)
>> +		goto err_hid_close;
>> +
>> +	hid_set_drvdata(hdev, dev);
>> +	dev->hdev = hdev;
>> +
>> +	mutex_init(&dev->lock);
>> +	init_completion(&dev->wait);
>> +
>> +	if (!dev->ft260_is_serial) {
>> +		ret = ft260_i2c_probe(hdev, dev);
>> +		if (ret)
>> +			goto err_hid_close;
>> +	} else {
>> +		ret = ft260_uart_probe(hdev, dev);
>> +		if (ret)
>> +			goto err_hid_close;
>> +	}
>> +
>> +	return 0;
>> +
>>   err_hid_close:
>>   	hid_hw_close(hdev);
>>   err_hid_stop:
>> @@ -1055,8 +1608,15 @@ static void ft260_remove(struct hid_device *hdev)
>>   	if (!dev)
>>   		return;
>>   
>> -	sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
>> -	i2c_del_adapter(&dev->adap);
>> +	if (dev->ft260_is_serial) {
>> +		tty_port_unregister_device(&dev->port, ft260_tty_driver,
>> +					   dev->index);
>> +		ft260_uart_port_remove(dev);
>> +		cancel_work_sync(&dev->wakeup_work);
>> +	} else {
>> +		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
>> +		i2c_del_adapter(&dev->adap);
>> +	}
>>   
>>   	hid_hw_close(hdev);
>>   	hid_hw_stop(hdev);
>> @@ -1066,7 +1626,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
>>   			   u8 *data, int size)
>>   {
>>   	struct ft260_device *dev = hid_get_drvdata(hdev);
>> -	struct ft260_i2c_input_report *xfer = (void *)data;
>> +	struct ft260_input_report *xfer = (void *)data;
>>   
>>   	if (xfer->report >= FT260_I2C_REPORT_MIN &&
>>   	    xfer->report <= FT260_I2C_REPORT_MAX) {
>> @@ -1087,9 +1647,16 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
>>   		if (dev->read_idx == dev->read_len)
>>   			complete(&dev->wait);
>>   
>> +	} else if (xfer->length > FT260_RD_DATA_MAX) {
>> +		hid_err(hdev, "Received data too long (%d)\n", xfer->length);
>> +		return -EBADR;
>> +	} else if (xfer->report >= FT260_UART_REPORT_MIN &&
>> +		   xfer->report <= FT260_UART_REPORT_MAX) {
>> +		return ft260_uart_receive_chars(dev, xfer->data, xfer->length);
>>   	} else {
>>   		hid_err(hdev, "unhandled report %#02x\n", xfer->report);
>>   	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1101,7 +1668,62 @@ static struct hid_driver ft260_driver = {
>>   	.raw_event	= ft260_raw_event,
>>   };
>>   
>> -module_hid_driver(ft260_driver);
>> -MODULE_DESCRIPTION("FTDI FT260 USB HID to I2C host bridge");
>> +static int __init ft260_driver_init(void)
>> +{
>> +	int ret;
>> +
>> +	ft260_tty_driver = tty_alloc_driver(UART_COUNT_MAX,
>> +		TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
>> +	if (IS_ERR(ft260_tty_driver)) {
>> +		pr_err("tty_alloc_driver failed: %d\n",
>> +			(int)PTR_ERR(ft260_tty_driver));
>> +		return PTR_ERR(ft260_tty_driver);
>> +	}
>> +
>> +	ft260_tty_driver->driver_name = "ft260_ser";
>> +	ft260_tty_driver->name = "ttyFT";
> Again, where did this name come from?  And it doesn't match the
> changelog text :(
>
> thanks,
>
> greg k-h

