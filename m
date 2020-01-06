Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58805130DE9
	for <lists+linux-serial@lfdr.de>; Mon,  6 Jan 2020 08:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAFHWh (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 6 Jan 2020 02:22:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFHWh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jan 2020 02:22:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so26487582pgf.1;
        Sun, 05 Jan 2020 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yldMC+FytKnLzh398bTNPUaCSuwPlECPHs4DM/jLGBo=;
        b=J0Pz3xyUCmX8evmLLPETxc5qieXCV31GCVeUdtgz5Y3BaO93YsgYQrXkh4XchrdTYL
         g718UPqphlsikpV7/un9Ydtf501VuNFBzSwDGdV+mWpu7G680SfS4NvDxmC8ETVA4oc2
         Af8EQztkXX5gmu1Iz+MLMT9YsFFjR/2HsoBbaMwieQ2Gpo3TKYsi/DPG7R/tEyqNWoNH
         BYO/mHkShCpEmFbYuPtxqhtK1V9dMthi81vtWYroG1Ql/OBdID93rkQ5Lqr+5J2fj2U+
         dbhZpSTeIpTG1nTpbqsuJtyoW3oGRREIBCWxuU3iUXZmOGwGKNqQp/FNjQd1EXZ0ETY1
         TxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yldMC+FytKnLzh398bTNPUaCSuwPlECPHs4DM/jLGBo=;
        b=K8Bgu0bz215b2Cgyi+cblBsJW+E68eLeh8LiJJDzZs6sUxy7EqWTgnKoPhhmVuZ4MX
         +IYH2Z39ceVm8u8CRvktqiIP1y6ChxrkUCktzosUX3JCdpX1Q3rvB2T8QS8gu8VRtk18
         z246ldLL/G7XR75kh3sUgsQJPAZI5rmvicuO/qYGm6miiixjttP0vkpqnXIiM69kG1CE
         qn+UCE4Erd+WKpJbpOetUtHPm2ptiR+uDKN7mTfNsF/JFKRodeyDULeWGDj0ajkYU+sp
         J23CnhnRg3pOSLMyG7EFnLKBV5ztpY9ZuG1+AJ9p+ursWYbafPmyIMgcBuH5ffXlmePi
         unXQ==
X-Gm-Message-State: APjAAAWQe4Jdg8AnL3b5q9KQgCY9EaRA8p3YMKQO/w8bgg1AbijNQ86p
        eziAt18mY9ypF0KA9Ww2h4XKGhzt
X-Google-Smtp-Source: APXvYqz2YJvJXs0LDr+fPD7J3QIisJtMkC0tAXS8XZ5AXIs9/6u+1nb5cGBqsQiLa3P05F6Ns8r3Vw==
X-Received: by 2002:a63:1418:: with SMTP id u24mr105761603pgl.279.1578295354125;
        Sun, 05 Jan 2020 23:22:34 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.131])
        by smtp.gmail.com with ESMTPSA id q8sm72968137pgg.92.2020.01.05.23.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 23:22:33 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v1 2/3] tty/serial: ttvys: add null modem driver emulating serial port
Date:   Mon,  6 Jan 2020 12:51:54 +0530
Message-Id: <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1578235515.git.gupt21@gmail.com>
References: <cover.1578235515.git.gupt21@gmail.com>
In-Reply-To: <cover.1578235515.git.gupt21@gmail.com>
References: <cover.1578235515.git.gupt21@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This commit adds driver that can create virtual tty devices.
This is useful in software testing and gps data simulation.

Devices are created either through DT or by writing to device
node. Serial port events like frame, parity, overflow errors
are also emulated by writing to sysfs files.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 MAINTAINERS          |    8 +
 drivers/tty/Kconfig  |   16 +
 drivers/tty/Makefile |    1 +
 drivers/tty/ttyvs.c  | 2429 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 2454 insertions(+)
 create mode 100644 drivers/tty/ttyvs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c6b893f..350fb36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16794,6 +16794,14 @@ F:	include/uapi/linux/serial_core.h
 F:	include/uapi/linux/serial.h
 F:	include/uapi/linux/tty.h
 
+TTYVS VIRTUAL SERIAL DRIVER
+M:	Rishi Gupta <gupt21@gmail.com>
+L:	linux-serial@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/ttyvs.yaml
+F:	drivers/tty/ttyvs.c
+
 TUA9001 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index a312cb3..1e843f9 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -477,4 +477,20 @@ config LDISC_AUTOLOAD
 	  dev.tty.ldisc_autoload sysctl, this configuration option will
 	  only set the default value of this functionality.
 
+config TTY_VS
+	tristate "Virtual serial null modem emulation"
+	help
+	  This driver creates virtual serial port devices (loopback and
+	  null modem style) that can be used in the same way as real serial
+	  port devices. Parity, frame, overflow, ring indicator, baudrate
+	  mismatch, hardware and software flow control can be emulated.
+
+	  For information about how to create/delete devices, exchange data
+	  and emulate events, please read:
+	  <file:Documentation/devicetree/bindings/serial/ttyvs.yaml>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ttyvs.ko. If you want to compile this driver
+	  into the kernel, say Y here.
+
 endif # TTY
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 020b1cd..c5f2b4c 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
+obj-$(CONFIG_TTY_VS)	+= ttyvs.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/ttyvs.c b/drivers/tty/ttyvs.c
new file mode 100644
index 0000000..894346c
--- /dev/null
+++ b/drivers/tty/ttyvs.c
@@ -0,0 +1,2429 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Serial port null modem emulation driver
+ *
+ * Copyright (c) 2020, Rishi Gupta <gupt21@gmail.com>
+ */
+
+/*
+ * Virtual multi-port serial card:
+ *
+ * This driver implements a virtual multi-port serial card in such a
+ * way that the virtual card can have 0 to N number of virtual serial
+ * ports (tty devices). The devices created in this card are used in
+ * exactly the same way as the real tty devices using standard termios
+ * and Linux/Posix APIs.
+ *
+ *    /dev/ttyvs_card
+ *  +~~~~~~~~~~~~~~~~~~~~~+
+ *  |   +-------------+   |
+ *  |   | /dev/ttyvs0 |   |
+ *  |   +-------------+   |
+ *  |   .                 |
+ *  |   .                 |
+ *  |   +-------------+   |
+ *  |   | /dev/ttyvsN |   |
+ *  |   +-------------+   |
+ *  +~~~~~~~~~~~~~~~~~~~~~+
+ *
+ * DT bindings: Documentation/devicetree/bindings/serial/ttyvs.yaml
+ *
+ * Example udev rules:
+ * 1. Permissions on card's node to create/destroy and query information:
+ *    ACTION=="add", SUBSYSTEM=="misc", KERNEL=="ttyvs_card", MODE="0666"
+ *
+ * 2. Permission on tty device nodes and event sysfs files (%S is sysfs
+ *    mount point and %p is DEVPATH /devices/virtual/tty/ttyvsNUM):
+ *    ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyvs[0-9]*",\
+ *    MODE="0666", RUN+="/bin/chmod 0666 %S%p/event %S%p/faultycable"
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/sched.h>
+#include <linux/version.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/miscdevice.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+/* Pin out configurations definitions */
+#define VS_CON_CTS    0x0001
+#define VS_CON_DCD    0x0002
+#define VS_CON_DSR    0x0004
+#define VS_CON_RI     0x0008
+
+/* Modem control register definitions */
+#define VS_MCR_DTR    0x0001
+#define VS_MCR_RTS    0x0002
+#define VS_MCR_LOOP   0x0004
+
+/* Modem status register definitions */
+#define VS_MSR_CTS    0x0008
+#define VS_MSR_DCD    0x0010
+#define VS_MSR_RI     0x0020
+#define VS_MSR_DSR    0x0040
+
+/* UART frame structure definitions */
+#define VS_CRTSCTS       0x0001
+#define VS_XON           0x0002
+#define VS_NONE          0X0004
+#define VS_DATA_5        0X0008
+#define VS_DATA_6        0X0010
+#define VS_DATA_7        0X0020
+#define VS_DATA_8        0X0040
+#define VS_PARITY_NONE   0x0080
+#define VS_PARITY_ODD    0x0100
+#define VS_PARITY_EVEN   0x0200
+#define VS_PARITY_MARK   0x0400
+#define VS_PARITY_SPACE  0x0800
+#define VS_STOP_1        0x1000
+#define VS_STOP_2        0x2000
+
+/* Constants for the device type (odevtyp) */
+#define VS_SNM 0x0001
+#define VS_CNM 0x0002
+#define VS_SLB 0x0003
+#define VS_CLB 0x0004
+
+/* Represents a virtual tty device in this virtual card */
+struct vs_dev {
+	/* index for this device in tty core */
+	unsigned int own_index;
+	/* index of the device to which this device is connected */
+	unsigned int peer_index;
+	/* shadow modem status register */
+	int msr_reg;
+	/* shadow modem control register */
+	int mcr_reg;
+	/* rts line connections for this device */
+	int rts_mappings;
+	/* dtr line connections for this device */
+	int dtr_mappings;
+	int set_odtr_at_open;
+	int set_pdtr_at_open;
+	int odevtyp;
+	/* mutual exclusion at device level */
+	struct mutex lock;
+	int is_break_on;
+	/* currently active baudrate */
+	int baud;
+	int uart_frame;
+	int waiting_msr_chg;
+	int tx_paused;
+	int faulty_cable;
+	struct tty_struct *own_tty;
+	struct tty_struct *peer_tty;
+	struct serial_struct serial;
+	struct async_icount icount;
+	struct device *device;
+};
+
+/*
+ * Associates index of the device as managed by index manager
+ * to its device specific data.
+ */
+struct vs_info {
+	int index;
+	struct vs_dev *vsdev;
+};
+
+/*
+ * Root of database of all devices managed by this driver. Devices
+ * are referenced using this root. For ex; to retreive struct vs_dev
+ * of 3rd device use db[3].vsdev.
+ */
+static struct vs_info *db;
+
+/*
+ * This is used to create and destroy devices atomically.
+ */
+static DEFINE_MUTEX(card_lock);
+
+/* Describes this driver */
+static struct tty_driver *ttyvs_driver;
+
+/* Module params / device-tree properties */
+#define VS_DEFAULT_MAX_DEV 64
+static ushort max_num_vs_devs = VS_DEFAULT_MAX_DEV;
+static ushort init_num_nm_pairs;
+static ushort init_num_lb_devs;
+
+/* Gives how many null modem pairs exist at present */
+static ushort total_nm_pair;
+
+/* Gives how many loop back devices exist at present */
+static ushort total_lb_devs;
+
+/*
+ * Once device(s) is created by using next available free number,
+ * user space needs to know which device number it should use (find
+ * 'X' in /dev/ttyvsX. These holds this number(s).
+ */
+static int last_lbdev_idx  = -1;
+static int last_nmdev1_idx = -1;
+static int last_nmdev2_idx = -1;
+
+/*
+ * Notifies tty core that a framing/parity/overrun error has happend
+ * while receiving data on serial port. When frame or parity error
+ * happens, -7 (randomly selected number by this driver) is sent as
+ * byte that got corrupted to tty core. For emulation purpose 0 can
+ * not be taken as corrupted byte because parity and break both will
+ * have same sequence (octal \377 \0 \0) and therefore application
+ * will not be able to differentiate between these two.
+ *
+ * This is also used for asserting/de-asserting ring event on line and
+ * notifies tty core when a break condition has been detected on line.
+ *
+ * 1. Emulate framing error:
+ * $ echo "1" > /sys/devices/virtual/tty/ttyvs0/event
+ *
+ * 2. Emulate parity error:
+ * $ echo "2" > /sys/devices/virtual/tty/ttyvs0/event
+ *
+ * 3. Emulate overrun error:
+ * $ echo "3" > /sys/devices/virtual/tty/ttyvs0/event
+ *
+ * 4. Emulate ring indicator (set RI signal):
+ * $ echo "4" > /sys/devices/virtual/tty/ttyvs0/event
+ *
+ * 5. Emulate ring indicator (unset RI signal):
+ * $ echo "5" > /sys/devices/virtual/tty/ttyvs0/event
+ *
+ * 6. Emulate break received:
+ * $ echo "6" > /sys/devices/virtual/tty/ttyvs0/event
+ */
+static ssize_t event_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret, push = 1;
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+	struct tty_struct *tty_to_write = local_vsdev->own_tty;
+
+	if (!buf || (count <= 0))
+		return -EINVAL;
+
+	/*
+	 * Ensure required structure has been allocated, initialized and
+	 * port has been opened.
+	 */
+	if (!tty_to_write || (tty_to_write->port == NULL)
+			|| (tty_to_write->port->count <= 0))
+		return -EIO;
+	if (!test_bit(ASYNCB_INITIALIZED, &tty_to_write->port->flags))
+		return -EIO;
+
+	mutex_lock(&local_vsdev->lock);
+
+	switch (buf[0]) {
+	case '1':
+		ret = tty_insert_flip_char(tty_to_write->port, -7, TTY_FRAME);
+		if (ret < 0)
+			goto fail;
+		local_vsdev->icount.frame++;
+		break;
+	case '2':
+		ret = tty_insert_flip_char(tty_to_write->port, -7, TTY_PARITY);
+		if (ret < 0)
+			goto fail;
+		local_vsdev->icount.parity++;
+		break;
+	case '3':
+		ret = tty_insert_flip_char(tty_to_write->port, 0, TTY_OVERRUN);
+		if (ret < 0)
+			goto fail;
+		local_vsdev->icount.overrun++;
+		break;
+	case '4':
+		local_vsdev->msr_reg |= VS_MSR_RI;
+		local_vsdev->icount.rng++;
+		push = -1;
+		break;
+	case '5':
+		local_vsdev->msr_reg &= ~VS_MSR_RI;
+		local_vsdev->icount.rng++;
+		push = -1;
+		break;
+	case '6':
+		ret = tty_insert_flip_char(tty_to_write->port, 0, TTY_BREAK);
+		if (ret < 0)
+			goto fail;
+		local_vsdev->icount.brk++;
+		break;
+	default:
+		mutex_unlock(&local_vsdev->lock);
+		return -EINVAL;
+	}
+
+	if (push)
+		tty_flip_buffer_push(tty_to_write->port);
+
+	mutex_unlock(&local_vsdev->lock);
+	return count;
+
+fail:
+	mutex_unlock(&local_vsdev->lock);
+	return ret;
+}
+static DEVICE_ATTR_WO(event);
+
+/*
+ * Emulates a faulty cable condition. Data is sent successfully from
+ * sender end but receiving end will never receive it.
+ *
+ * 1. Emulate cable is faulty:
+ * $ echo "1" > /sys/devices/virtual/tty/ttyvs0/faultycable
+ *
+ * 2. Emulate cable is not faulty (default):
+ * $ echo "0" > /sys/devices/virtual/tty/ttyvs0/faultycable
+ */
+static ssize_t faultycable_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf || (count <= 0))
+		return -EINVAL;
+
+	switch (buf[0]) {
+	case '0':
+		local_vsdev->faulty_cable = 0;
+		break;
+	case '1':
+		local_vsdev->faulty_cable = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(faultycable);
+
+/*
+ * Gives index of the tty device corresponding to this sysfs node.
+ * $cat /sys/devices/virtual/tty/ttyvs0/ownidx
+ */
+static ssize_t ownidx_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", local_vsdev->own_index);
+}
+static DEVICE_ATTR_RO(ownidx);
+
+/*
+ * Gives index of the tty device to which given tty devices is
+ * connected.
+ * $cat /sys/devices/virtual/tty/ttyvs0/peeridx
+ */
+static ssize_t peeridx_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", local_vsdev->peer_index);
+}
+static DEVICE_ATTR_RO(peeridx);
+
+/*
+ * Gives RTS line connections for the given tty device.
+ * $cat /sys/devices/virtual/tty/ttyvs0/ortsmap
+ */
+static ssize_t ortsmap_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", local_vsdev->rts_mappings);
+}
+static DEVICE_ATTR_RO(ortsmap);
+
+/*
+ * Gives DTR line connections for the given tty device.
+ * $cat /sys/devices/virtual/tty/ttyvs0/odtrmap
+ */
+static ssize_t odtrmap_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", local_vsdev->dtr_mappings);
+}
+static DEVICE_ATTR_RO(odtrmap);
+
+/*
+ * Gives RTS line connections of the tty device to which the
+ * given tty device is connected.
+ * $cat /sys/devices/virtual/tty/ttyvs0/prtsmap
+ */
+static ssize_t prtsmap_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *remote_vsdev;
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if ((local_vsdev->own_index == local_vsdev->peer_index) || !buf)
+		return -EINVAL;
+
+	remote_vsdev = db[local_vsdev->peer_index].vsdev;
+	return sprintf(buf, "%u\n", remote_vsdev->rts_mappings);
+}
+static DEVICE_ATTR_RO(prtsmap);
+
+/*
+ * Gives DTR line connections of the tty device to which the
+ * given tty device is connected.
+ * $cat /sys/devices/virtual/tty/ttyvs0/pdtrmap
+ */
+static ssize_t pdtrmap_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *remote_vsdev;
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if ((local_vsdev->own_index == local_vsdev->peer_index) || !buf)
+		return -EINVAL;
+
+	remote_vsdev = db[local_vsdev->peer_index].vsdev;
+	return sprintf(buf, "%u\n", remote_vsdev->dtr_mappings);
+}
+static DEVICE_ATTR_RO(pdtrmap);
+
+/*
+ * Gives type (loopback / null modem) of the given tty device.
+ * $cat /sys/devices/virtual/tty/ttyvs0/odevtyp
+ */
+static ssize_t odevtyp_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", local_vsdev->odevtyp);
+}
+static DEVICE_ATTR_RO(odevtyp);
+
+/*
+ * Return value of 1 means, DTR signal will be asserted when given
+ * this tty device is opeded. Value 0 means it will not be asserted.
+ * $cat /sys/devices/virtual/tty/ttyvs0/odtropn
+ */
+static ssize_t odtropn_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", local_vsdev->set_odtr_at_open);
+}
+static DEVICE_ATTR_RO(odtropn);
+
+/*
+ * Return value of 1 means, DTR signal of the peer tty device will
+ * be asserted when given peer tty device is opeded. Value 0 means
+ * it will not be asserted.
+ * $cat /sys/devices/virtual/tty/ttyvs0/pdtropn
+ */
+static ssize_t pdtropn_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf)
+		return -EINVAL;
+
+	return sprintf(buf, "%u\n", local_vsdev->set_odtr_at_open);
+}
+static DEVICE_ATTR_RO(pdtropn);
+
+/*
+ * Gives serial port data/events stats.
+ * $cat /sys/devices/virtual/tty/ttyvs0/ostats
+ */
+static ssize_t ostats_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct vs_dev *local_vsdev = dev_get_drvdata(dev);
+
+	if (!buf)
+		return -EINVAL;
+
+	return sprintf(buf, "%u#%u#%u#%u#%u#%u#%u#%u#%u#%u#%u#\n",
+			local_vsdev->icount.tx, local_vsdev->icount.rx,
+			local_vsdev->icount.cts, local_vsdev->icount.dcd,
+			local_vsdev->icount.dsr, local_vsdev->icount.brk,
+			local_vsdev->icount.rng, local_vsdev->icount.frame,
+			local_vsdev->icount.parity, local_vsdev->icount.overrun,
+			local_vsdev->icount.buf_overrun);
+}
+static DEVICE_ATTR_RO(ostats);
+
+static struct attribute *vs_info_attrs[] = {
+	&dev_attr_event.attr,
+	&dev_attr_faultycable.attr,
+	&dev_attr_ownidx.attr,
+	&dev_attr_peeridx.attr,
+	&dev_attr_ortsmap.attr,
+	&dev_attr_odtrmap.attr,
+	&dev_attr_prtsmap.attr,
+	&dev_attr_pdtrmap.attr,
+	&dev_attr_odevtyp.attr,
+	&dev_attr_odtropn.attr,
+	&dev_attr_pdtropn.attr,
+	&dev_attr_ostats.attr,
+	NULL,
+};
+
+static const struct attribute_group vs_info_attr_grp = {
+	.attrs = vs_info_attrs,
+};
+
+/*
+ * Checks if the given serial port has received its carrier detect
+ * line raised or not. Return 1 if the carrier is raised otherwise 0.
+ */
+static int vs_port_carrier_raised(struct tty_port *port)
+{
+	struct vs_dev *local_vsdev = db[port->tty->index].vsdev;
+
+	return (local_vsdev->msr_reg & VS_MSR_DCD) ? 1 : 0;
+}
+
+/* Shutdown the given serial port */
+static void vs_port_shutdown(struct tty_port *port)
+{
+	pr_debug("shutting down the port!\n");
+}
+
+/*
+ * Invoked when tty is going to be destroyed and driver should
+ * release resources.
+ */
+static void vs_port_destruct(struct tty_port *port)
+{
+	pr_debug("destroying the port!\n");
+}
+
+/* Activate the given serial port as opposed to shutdown */
+static int vs_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	return 0;
+}
+
+static const struct tty_port_operations vs_port_ops = {
+	.carrier_raised = vs_port_carrier_raised,
+	.shutdown       = vs_port_shutdown,
+	.activate       = vs_port_activate,
+	.destruct       = vs_port_destruct,
+};
+
+/*
+ * Update modem control and status registers according to the bit
+ * mask(s) provided. The RTS and DTR values can be set only if the
+ * current handshaking state of the tty device allows direct control
+ * of the modem control lines. The pin mappings are honoured.
+ *
+ * Caller holds lock of thegiven virtual tty device.
+ */
+static int vs_update_modem_lines(struct tty_struct *tty,
+			unsigned int set, unsigned int clear)
+{
+	int ctsint = 0;
+	int dcdint = 0;
+	int dsrint = 0;
+	int rngint = 0;
+	int mcr_ctrl_reg = 0;
+	int wakeup_blocked_open = 0;
+	int rts_mappings, dtr_mappings, msr_state_reg;
+	struct async_icount *evicount;
+	struct vs_dev *vsdev, *local_vsdev, *remote_vsdev;
+
+	local_vsdev = db[tty->index].vsdev;
+
+	/* Read modify write MSR register */
+	if (tty->index != local_vsdev->peer_index) {
+		remote_vsdev = db[local_vsdev->peer_index].vsdev;
+		msr_state_reg = remote_vsdev->msr_reg;
+		vsdev = remote_vsdev;
+	} else {
+		msr_state_reg = local_vsdev->msr_reg;
+		vsdev = local_vsdev;
+	}
+
+	rts_mappings = local_vsdev->rts_mappings;
+	dtr_mappings = local_vsdev->dtr_mappings;
+
+	if (set & TIOCM_RTS) {
+		mcr_ctrl_reg |= VS_MCR_RTS;
+		if ((rts_mappings & VS_CON_CTS) == VS_CON_CTS) {
+			msr_state_reg |= VS_MSR_CTS;
+			ctsint++;
+		}
+		if ((rts_mappings & VS_CON_DCD) == VS_CON_DCD) {
+			msr_state_reg |= VS_MSR_DCD;
+			dcdint++;
+			wakeup_blocked_open = 1;
+		}
+		if ((rts_mappings & VS_CON_DSR) == VS_CON_DSR) {
+			msr_state_reg |= VS_MSR_DSR;
+			dsrint++;
+		}
+		if ((rts_mappings & VS_CON_RI) == VS_CON_RI) {
+			msr_state_reg |= VS_MSR_RI;
+			rngint++;
+		}
+	}
+
+	if (set & TIOCM_DTR) {
+		mcr_ctrl_reg |= VS_MCR_DTR;
+		if ((dtr_mappings & VS_CON_CTS) == VS_CON_CTS) {
+			msr_state_reg |= VS_MSR_CTS;
+			ctsint++;
+		}
+		if ((dtr_mappings & VS_CON_DCD) == VS_CON_DCD) {
+			msr_state_reg |= VS_MSR_DCD;
+			dcdint++;
+			wakeup_blocked_open = 1;
+		}
+		if ((dtr_mappings & VS_CON_DSR) == VS_CON_DSR) {
+			msr_state_reg |= VS_MSR_DSR;
+			dsrint++;
+		}
+		if ((dtr_mappings & VS_CON_RI) == VS_CON_RI) {
+			msr_state_reg |= VS_MSR_RI;
+			rngint++;
+		}
+	}
+
+	if (clear & TIOCM_RTS) {
+		mcr_ctrl_reg &= ~VS_MCR_RTS;
+		if ((rts_mappings & VS_CON_CTS) == VS_CON_CTS) {
+			msr_state_reg &= ~VS_MSR_CTS;
+			ctsint++;
+		}
+		if ((rts_mappings & VS_CON_DCD) == VS_CON_DCD) {
+			msr_state_reg &= ~VS_MSR_DCD;
+			dcdint++;
+		}
+		if ((rts_mappings & VS_CON_DSR) == VS_CON_DSR) {
+			msr_state_reg &= ~VS_MSR_DSR;
+			dsrint++;
+		}
+		if ((rts_mappings & VS_CON_RI) == VS_CON_RI) {
+			msr_state_reg &= ~VS_MSR_RI;
+			rngint++;
+		}
+	}
+
+	if (clear & TIOCM_DTR) {
+		mcr_ctrl_reg &= ~VS_MCR_DTR;
+		if ((dtr_mappings & VS_CON_CTS) == VS_CON_CTS) {
+			msr_state_reg &= ~VS_MSR_CTS;
+			ctsint++;
+		}
+		if ((dtr_mappings & VS_CON_DCD) == VS_CON_DCD) {
+			msr_state_reg &= ~VS_MSR_DCD;
+			dcdint++;
+		}
+		if ((dtr_mappings & VS_CON_DSR) == VS_CON_DSR) {
+			msr_state_reg &= ~VS_MSR_DSR;
+			dsrint++;
+		}
+		if ((dtr_mappings & VS_CON_RI) == VS_CON_RI) {
+			msr_state_reg &= ~VS_MSR_RI;
+			rngint++;
+		}
+	}
+
+	local_vsdev->mcr_reg = mcr_ctrl_reg;
+	vsdev->msr_reg = msr_state_reg;
+
+	evicount = &vsdev->icount;
+	evicount->cts += ctsint;
+	evicount->dsr += dsrint;
+	evicount->dcd += dcdint;
+	evicount->rng += rngint;
+
+	if (vsdev->own_tty && vsdev->own_tty->port) {
+		/* Wake up process blocked on TIOCMIWAIT ioctl */
+		if ((vsdev->waiting_msr_chg == 1) &&
+				(vsdev->own_tty->port->count > 0)) {
+			wake_up_interruptible(
+					&vsdev->own_tty->port->delta_msr_wait);
+		}
+
+		/* Wake up application blocked on carrier detect signal */
+		if ((wakeup_blocked_open == 1) &&
+				(vsdev->own_tty->port->blocked_open > 0)) {
+			wake_up_interruptible(&vsdev->own_tty->port->open_wait);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Invoked when user space process opens a serial port. The tty core
+ * calls this to install tty and initialize the required resources.
+ */
+static int vs_install(struct tty_driver *drv, struct tty_struct *tty)
+{
+	int ret;
+	struct tty_port *port;
+
+	port = kcalloc(1, sizeof(struct tty_port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	/* First initialize and then set port operations */
+	tty_port_init(port);
+	port->ops = &vs_port_ops;
+
+	ret = tty_port_install(port, drv, tty);
+	if (ret) {
+		kfree(port);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Invoked when there exist no user process or tty is to be
+ * released explicitly for whatever reason.
+ */
+static void vs_cleanup(struct tty_struct *tty)
+{
+	tty_port_put(tty->port);
+}
+
+/*
+ * Called when open system call is called on virtual tty device node.
+ * The tty core allocates 'struct tty_struct' for this device and
+ * set up various resources, sets up line discipline and call this
+ * function. For first time allocation happens and from next time
+ * onwards only re-opening happens.
+ *
+ * The tty core finds the tty driver serving this device node and the
+ * index of this tty device as registered by this driver with tty core.
+ * From this inded we retrieve the virtual tty device to work on.
+ *
+ * If the same serial port is opened more than once, the tty structure
+ * passed to this function will be same but filp structure will be
+ * different every time. Caller holds tty lock.
+ *
+ * This driver does not set CLOCAL by default. This means that the
+ * open() system call will block until it find its carrier detect
+ * line raised. Application should use O_NONBLOCK/O_NDELAY flag if
+ * it does not want to wait for DCD line change.
+ */
+static int vs_open(struct tty_struct *tty, struct file *filp)
+{
+	int ret;
+	struct vs_dev *remote_vsdev;
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	local_vsdev->own_tty = tty;
+
+	/*
+	 * If this device is one end of a null modem connection,
+	 * provide its address to remote end.
+	 */
+	if (tty->index != local_vsdev->peer_index) {
+		remote_vsdev = db[local_vsdev->peer_index].vsdev;
+		remote_vsdev->peer_tty = tty;
+	}
+
+	memset(&local_vsdev->serial, 0, sizeof(struct serial_struct));
+	memset(&local_vsdev->icount, 0, sizeof(struct async_icount));
+
+	/*
+	 * Handle DTR raising logic ourselve instead of tty_port helpers
+	 * doing it. Locking virtual tty is not required here.
+	 */
+	if (local_vsdev->set_odtr_at_open == 1)
+		vs_update_modem_lines(tty, TIOCM_DTR | TIOCM_RTS, 0);
+
+	/* Associate tty with port and do port level opening. */
+	ret = tty_port_open(tty->port, tty, filp);
+	if (ret)
+		return ret;
+
+	tty->port->close_delay  = 0;
+	tty->port->closing_wait = ASYNC_CLOSING_WAIT_NONE;
+	tty->port->drain_delay  = 0;
+
+	return ret;
+}
+
+/*
+ * Invoked by tty layer when release() is called on the file pointer
+ * that was previously created with a call to open().
+ */
+static void vs_close(struct tty_struct *tty, struct file *filp)
+{
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
+		return;
+
+	if (tty && filp && tty->port && (tty->port->count > 0))
+		tty_port_close(tty->port, tty, filp);
+
+	if (tty && C_HUPCL(tty) && tty->port && (tty->port->count < 1))
+		vs_update_modem_lines(tty, 0, TIOCM_DTR | TIOCM_RTS);
+}
+
+/*
+ * Invoked when write() system call is invoked on device node.
+ * This function constructs evry byte as per the current uart
+ * frame settings. Finally, the data is inserted into the tty
+ * buffer of the receiver tty device.
+ */
+static int vs_write(struct tty_struct *tty,
+			const unsigned char *buf, int count)
+{
+	int x;
+	unsigned char *data = NULL;
+	struct tty_struct *tty_to_write = NULL;
+	struct vs_dev *rx_vsdev = NULL;
+	struct vs_dev *tx_vsdev = db[tty->index].vsdev;
+
+	if (tx_vsdev->tx_paused || !tty || tty->stopped
+			|| (count < 1) || !buf || tty->hw_stopped)
+		return 0;
+
+	if (tx_vsdev->is_break_on == 1) {
+		pr_debug("break condition is on!\n");
+		return -EIO;
+	}
+
+	if (tx_vsdev->faulty_cable == 1)
+		return count;
+
+	if (tty->index != tx_vsdev->peer_index) {
+		/* Null modem */
+		tty_to_write = tx_vsdev->peer_tty;
+		rx_vsdev = db[tx_vsdev->peer_index].vsdev;
+
+		if ((tx_vsdev->baud != rx_vsdev->baud) ||
+			(tx_vsdev->uart_frame != rx_vsdev->uart_frame)) {
+			/*
+			 * Emulate data sent but not received due to
+			 * mismatched baudrate/framing.
+			 */
+			pr_debug("mismatched serial port settings!\n");
+			tx_vsdev->icount.tx++;
+			return count;
+		}
+	} else {
+		/* Loop back */
+		tty_to_write = tty;
+		rx_vsdev = tx_vsdev;
+	}
+
+	if (tty_to_write) {
+		if ((tty_to_write->termios.c_cflag & CSIZE) == CS8) {
+			data = (unsigned char *)buf;
+		} else {
+			data = kcalloc(count, sizeof(char), GFP_KERNEL);
+			if (!data)
+				return -ENOMEM;
+
+			/* Emulate correct number of data bits */
+			switch (tty_to_write->termios.c_cflag & CSIZE) {
+			case CS7:
+				for (x = 0; x < count; x++)
+					data[x] = buf[x] & 0x7F;
+				break;
+			case CS6:
+				for (x = 0; x < count; x++)
+					data[x] = buf[x] & 0x3F;
+				break;
+			case CS5:
+				for (x = 0; x < count; x++)
+					data[x] = buf[x] & 0x1F;
+				break;
+			default:
+				data = (unsigned char *)buf;
+			}
+		}
+
+		tty_insert_flip_string(tty_to_write->port, data, count);
+		tty_flip_buffer_push(tty_to_write->port);
+		tx_vsdev->icount.tx++;
+		rx_vsdev->icount.rx++;
+
+		if (data != buf)
+			kfree(data);
+	} else {
+		/*
+		 * Other end is still not opened, emulate transmission from
+		 * local end but don't make other end receive it as is the
+		 * case in real world.
+		 */
+		tx_vsdev->icount.tx++;
+	}
+
+	return count;
+}
+
+/* Invoked by tty core to transmit single data byte. */
+static int vs_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	unsigned char data;
+	struct tty_struct *tty_to_write;
+	struct vs_dev *rx_vsdev;
+	struct vs_dev *tx_vsdev = db[tty->index].vsdev;
+
+	if (tx_vsdev->tx_paused || !tty || tty->stopped || tty->hw_stopped)
+		return 0;
+
+	if (tx_vsdev->is_break_on == 1)
+		return -EIO;
+
+	if (tx_vsdev->faulty_cable == 1)
+		return 1;
+
+	if (tty->index != tx_vsdev->peer_index) {
+		tty_to_write = tx_vsdev->peer_tty;
+		rx_vsdev = db[tx_vsdev->peer_index].vsdev;
+		if ((tx_vsdev->baud != rx_vsdev->baud) ||
+			(tx_vsdev->uart_frame != rx_vsdev->uart_frame)) {
+			tx_vsdev->icount.tx++;
+			return 1;
+		}
+	} else {
+		tty_to_write = tty;
+		rx_vsdev = tx_vsdev;
+	}
+
+	if (tty_to_write != NULL) {
+		switch (tty_to_write->termios.c_cflag & CSIZE) {
+		case CS8:
+			data = ch;
+			break;
+		case CS7:
+			data = ch & 0x7F;
+			break;
+		case CS6:
+			data = ch & 0x3F;
+			break;
+		case CS5:
+			data = ch & 0x1F;
+			break;
+		default:
+			data = ch;
+		}
+		tty_insert_flip_string(tty_to_write->port, &data, 1);
+		tty_flip_buffer_push(tty_to_write->port);
+		tx_vsdev->icount.tx++;
+		rx_vsdev->icount.rx++;
+	} else {
+		tx_vsdev->icount.tx++;
+	}
+
+	return 1;
+}
+
+/*
+ * Flush the data out of serial port. This driver immediately
+ * pushes data into receiver's tty buffer hence do nothing here.
+ */
+static void vs_flush_chars(struct tty_struct *tty)
+{
+	pr_debug("flushing the chars!\n");
+}
+
+/*
+ * Discard the internal output buffer for this tty device. Typically
+ * it may be called when executing IOCTL TCOFLUSH, closing the
+ * serial port, when break is received in input stream (flushing
+ * is configured) or when hangup occurs.
+ *
+ * On the other hand, when TCIFLUSH IOCTL is invoked, tty flip buffer
+ * and line discipline queue gets emptied without involvement of tty
+ * driver. The driver is generally expected not to keep data but send
+ * it to tty layer as soon as possible when it receives data.
+ *
+ * As this driver immediately pushes data into receiver's tty buffer
+ * hence do nothing here.
+ */
+static void vs_flush_buffer(struct tty_struct *tty)
+{
+	pr_debug("flushing the buffer!\n");
+}
+
+/* Provides information as a repsonse to TIOCGSERIAL IOCTL */
+static int vs_get_serinfo(struct tty_struct *tty, unsigned long arg)
+{
+	int ret;
+	struct serial_struct info;
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+	struct serial_struct serial = local_vsdev->serial;
+
+	if (!arg)
+		return -EFAULT;
+
+	memset(&info, 0, sizeof(info));
+
+	info.type		    = PORT_UNKNOWN;
+	info.line		    = serial.line;
+	info.port		    = tty->index;
+	info.irq			= 0;
+	info.flags		    = tty->port->flags;
+	info.xmit_fifo_size = 0;
+	info.baud_base	    = 0;
+	info.close_delay	= tty->port->close_delay;
+	info.closing_wait   = tty->port->closing_wait;
+	info.custom_divisor = 0;
+	info.hub6		    = 0;
+	info.io_type		= SERIAL_IO_MEM;
+
+	ret = copy_to_user((void __user *)arg, &info,
+				sizeof(struct serial_struct));
+
+	return ret ? -EFAULT : 0;
+}
+
+/* Returns number of bytes that can be queued to this device now */
+static int vs_write_room(struct tty_struct *tty)
+{
+	struct vs_dev *tx_vsdev = db[tty->index].vsdev;
+
+	if (tx_vsdev->tx_paused || !tty ||
+			tty->stopped || tty->hw_stopped)
+		return 0;
+
+	return 2048;
+}
+
+/*
+ * Invoked when serial terminal settings are chaged. The old_termios
+ * contains currently active settings and tty->termios contains new
+ * settings to be applied.
+ */
+static void vs_set_termios(struct tty_struct *tty,
+				struct ktermios *old_termios)
+{
+	u32 baud;
+	int uart_frame_settings;
+	unsigned int rts_mappings, dtr_mappings;
+	unsigned int mask = TIOCM_DTR;
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	rts_mappings = local_vsdev->rts_mappings;
+	dtr_mappings = local_vsdev->dtr_mappings;
+
+	mutex_lock(&local_vsdev->lock);
+
+	/*
+	 * Typically B0 is used to terminate the connection.
+	 * Drop RTS and DTR.
+	 */
+	if ((tty->termios.c_cflag & CBAUD) == B0) {
+		vs_update_modem_lines(tty, 0, TIOCM_DTR | TIOCM_RTS);
+		mutex_unlock(&local_vsdev->lock);
+		return;
+	}
+
+	/* If coming out of B0, raise DTR and RTS. This might get
+	 * overridden in next steps. Applications like minicom when
+	 * opens a serial port, may drop speed to B0 and then back
+	 * to normal speed again.
+	 */
+	if (!old_termios || (old_termios->c_cflag & CBAUD) == B0) {
+		if (!(tty->termios.c_cflag & CRTSCTS) ||
+				!test_bit(TTY_THROTTLED, &tty->flags)) {
+			mask |= TIOCM_RTS;
+			vs_update_modem_lines(tty, mask, 0);
+		}
+	}
+
+	baud = tty_get_baud_rate(tty);
+	if (!baud)
+		baud = 9600;
+
+	tty_encode_baud_rate(tty, baud, baud);
+
+	local_vsdev->baud = baud;
+
+	uart_frame_settings = 0;
+	if (tty->termios.c_cflag & CRTSCTS) {
+		uart_frame_settings |= VS_CRTSCTS;
+	} else if ((tty->termios.c_iflag & IXON) ||
+					(tty->termios.c_iflag & IXOFF)) {
+		uart_frame_settings |= VS_XON;
+	} else {
+		uart_frame_settings |= VS_NONE;
+	}
+
+	switch (tty->termios.c_cflag & CSIZE) {
+	case CS8:
+		uart_frame_settings |= VS_DATA_8;
+		break;
+	case CS7:
+		uart_frame_settings |= VS_DATA_7;
+		break;
+	case CS6:
+		uart_frame_settings |= VS_DATA_6;
+		break;
+	case CS5:
+		uart_frame_settings |= VS_DATA_5;
+		break;
+	default:
+		uart_frame_settings |= VS_DATA_8;
+	}
+
+	if (tty->termios.c_cflag & CSTOPB)
+		uart_frame_settings |= VS_STOP_2;
+	else
+		uart_frame_settings |= VS_STOP_1;
+
+	if (tty->termios.c_cflag & PARENB) {
+		if (tty->termios.c_cflag & CMSPAR) {
+			if (tty->termios.c_cflag & PARODD)
+				uart_frame_settings |= VS_PARITY_MARK;
+			else
+				uart_frame_settings |= VS_PARITY_SPACE;
+		} else {
+			if (tty->termios.c_cflag & PARODD)
+				uart_frame_settings |= VS_PARITY_ODD;
+			else
+				uart_frame_settings |= VS_PARITY_EVEN;
+		}
+	} else {
+		uart_frame_settings |= VS_PARITY_NONE;
+	}
+
+	local_vsdev->uart_frame = uart_frame_settings;
+
+	mutex_unlock(&local_vsdev->lock);
+}
+
+/*
+ * Returns the number of bytes in device's output queue. This is
+ * invoked when TIOCOUTQ IOCTL is executed or by tty core as and
+ * when required. Because we all push all data into receiver's
+ * end tty buffer, always return 0 here.
+ */
+static int vs_chars_in_buffer(struct tty_struct *tty)
+{
+	return 0;
+}
+
+/*
+ * Based on the number od interrupts check if any of the signal
+ * line has changed.
+ */
+static int vs_check_msr_delta(struct tty_struct *tty,
+		struct vs_dev *local_vsdev, unsigned long mask,
+		struct async_icount *prev)
+{
+	int delta;
+	struct async_icount now;
+
+	/*
+	 * Use tty-port initialised flag to detect all hangups
+	 * including the disconnect(device destroy) event.
+	 */
+	if (!test_bit(ASYNCB_INITIALIZED, &tty->port->flags))
+		return 1;
+
+	mutex_lock(&local_vsdev->lock);
+	now = local_vsdev->icount;
+	mutex_unlock(&local_vsdev->lock);
+	delta = ((mask & TIOCM_RNG && prev->rng != now.rng) ||
+			 (mask & TIOCM_DSR && prev->dsr != now.dsr) ||
+			 (mask & TIOCM_CAR && prev->dcd != now.dcd) ||
+			 (mask & TIOCM_CTS && prev->cts != now.cts));
+
+	*prev = now;
+	return delta;
+}
+
+/* Sleeps until at-least one of the modem lines changes */
+static int vs_wait_change(struct tty_struct *tty, unsigned long mask)
+{
+	int ret;
+	struct async_icount prev;
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	mutex_lock(&local_vsdev->lock);
+
+	local_vsdev->waiting_msr_chg = 1;
+	prev = local_vsdev->icount;
+
+	mutex_unlock(&local_vsdev->lock);
+
+	ret = wait_event_interruptible(tty->port->delta_msr_wait,
+			vs_check_msr_delta(tty, local_vsdev, mask, &prev));
+
+	local_vsdev->waiting_msr_chg = 0;
+
+	if (!ret && !test_bit(ASYNCB_INITIALIZED, &tty->port->flags))
+		ret = -EIO;
+
+	return ret;
+}
+
+/* Execute IOCTL commands */
+static int vs_ioctl(struct tty_struct *tty,
+				unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case TIOCGSERIAL:
+		return vs_get_serinfo(tty, arg);
+	case TIOCMIWAIT:
+		return vs_wait_change(tty, arg);
+	}
+
+	return -ENOIOCTLCMD;
+}
+
+/*
+ * Invoked when tty layer's input buffers are about to get full.
+ *
+ * When using RTS/CTS flow control, when RTS line is de-asserted,
+ * interrupt will be generated in hardware. The interrupt handler
+ * will raise a flag to indicate transmission should be stopped.
+ * This is achieved in this driver through tx_paused variable.
+ */
+static void vs_throttle(struct tty_struct *tty)
+{
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+	struct vs_dev *remote_vsdev = db[local_vsdev->peer_index].vsdev;
+
+	if (tty->termios.c_cflag & CRTSCTS) {
+		mutex_lock(&local_vsdev->lock);
+		remote_vsdev->tx_paused = 1;
+		vs_update_modem_lines(tty, 0, TIOCM_RTS);
+		mutex_unlock(&local_vsdev->lock);
+	} else if ((tty->termios.c_iflag & IXON) ||
+				(tty->termios.c_iflag & IXOFF)) {
+		vs_put_char(tty, STOP_CHAR(tty));
+	} else {
+		/* do nothing */
+	}
+}
+
+/*
+ * Invoked when the tty layer's input buffers have been emptied out,
+ * and it now can accept more data. Throttle/Unthrottle is about
+ * notifying remote end to start or stop data as per the currently
+ * active flow control. On the other hand, Start/Stop is about what
+ * action to take at local end itself to start or stop data as per
+ * the currently active flow control.
+ */
+static void vs_unthrottle(struct tty_struct *tty)
+{
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+	struct vs_dev *remote_vsdev = db[local_vsdev->peer_index].vsdev;
+
+	if (tty->termios.c_cflag & CRTSCTS) {
+		/* hardware (RTS/CTS) flow control */
+		mutex_lock(&local_vsdev->lock);
+		remote_vsdev->tx_paused = 0;
+		vs_update_modem_lines(tty, TIOCM_RTS, 0);
+		mutex_unlock(&local_vsdev->lock);
+
+		if (remote_vsdev->own_tty && remote_vsdev->own_tty->port)
+			tty_port_tty_wakeup(remote_vsdev->own_tty->port);
+	} else if ((tty->termios.c_iflag & IXON) ||
+				(tty->termios.c_iflag & IXOFF)) {
+		/* software flow control */
+		vs_put_char(tty, START_CHAR(tty));
+	} else {
+		/* do nothing */
+	}
+}
+
+/*
+ * Invoked when this driver should stop sending data for example
+ * as a part of flow control mechanism.
+ *
+ * Line discipline n_tty calls this function if this device uses
+ * software flow control and an XOFF character is received from
+ * other end.
+ */
+static void vs_stop(struct tty_struct *tty)
+{
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	mutex_lock(&local_vsdev->lock);
+	local_vsdev->tx_paused = 1;
+	mutex_unlock(&local_vsdev->lock);
+}
+
+/*
+ * Invoked when this driver should start sending data for example
+ * as a part of flow control mechanism.
+ *
+ * Line discipline n_tty calls this function if this device uses
+ * software flow control and an XON character is received from
+ * other end.
+ */
+static void vs_start(struct tty_struct *tty)
+{
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	mutex_lock(&local_vsdev->lock);
+	local_vsdev->tx_paused = 0;
+	mutex_unlock(&local_vsdev->lock);
+
+	if (tty && tty->port)
+		tty_port_tty_wakeup(tty->port);
+}
+
+/*
+ * Obtain the modem status bits for the given tty device. Invoked
+ * typically when TIOCMGET IOCTL is executed on the given
+ * tty device.
+ */
+static int vs_tiocmget(struct tty_struct *tty)
+{
+	int status, msr_reg, mcr_reg;
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	mutex_lock(&local_vsdev->lock);
+	mcr_reg = local_vsdev->mcr_reg;
+	msr_reg = local_vsdev->msr_reg;
+	mutex_unlock(&local_vsdev->lock);
+
+	status = ((mcr_reg & VS_MCR_DTR)  ? TIOCM_DTR  : 0) |
+			 ((mcr_reg & VS_MCR_RTS)  ? TIOCM_RTS  : 0) |
+			 ((mcr_reg & VS_MCR_LOOP) ? TIOCM_LOOP : 0) |
+			 ((msr_reg & VS_MSR_DCD)  ? TIOCM_CAR  : 0) |
+			 ((msr_reg & VS_MSR_RI)   ? TIOCM_RI   : 0) |
+			 ((msr_reg & VS_MSR_CTS)  ? TIOCM_CTS  : 0) |
+			 ((msr_reg & VS_MSR_DSR)  ? TIOCM_DSR  : 0);
+
+	return status;
+}
+
+/*
+ * Set the modem status bits. Invoked typically when TIOCMSET IOCTL
+ * is executed on the given tty device.
+ */
+static int vs_tiocmset(struct tty_struct *tty,
+				unsigned int set, unsigned int clear)
+{
+	int ret;
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	mutex_lock(&local_vsdev->lock);
+	ret = vs_update_modem_lines(tty, set, clear);
+	mutex_unlock(&local_vsdev->lock);
+
+	return ret;
+}
+
+/*
+ * Unconditionally assert/de-assert break condition of the given
+ * tty device.
+ */
+static int vs_break_ctl(struct tty_struct *tty, int break_state)
+{
+	struct tty_struct *tty_to_write;
+	struct vs_dev *brk_rx_vsdev;
+	struct vs_dev *brk_tx_vsdev = db[tty->index].vsdev;
+
+	if (tty->index != brk_tx_vsdev->peer_index) {
+		tty_to_write = brk_tx_vsdev->peer_tty;
+		brk_rx_vsdev = db[brk_tx_vsdev->peer_index].vsdev;
+	} else {
+		tty_to_write = tty;
+		brk_rx_vsdev = brk_tx_vsdev;
+	}
+
+	mutex_lock(&brk_tx_vsdev->lock);
+
+	if (break_state != 0) {
+		if (brk_tx_vsdev->is_break_on == 1)
+			return 0;
+
+		brk_tx_vsdev->is_break_on = 1;
+		if (tty_to_write != NULL) {
+			tty_insert_flip_char(tty_to_write->port, 0, TTY_BREAK);
+			tty_flip_buffer_push(tty_to_write->port);
+			brk_rx_vsdev->icount.brk++;
+		}
+	} else {
+		brk_tx_vsdev->is_break_on = 0;
+	}
+
+	mutex_unlock(&brk_tx_vsdev->lock);
+	return 0;
+}
+
+/*
+ * Invoked by tty layer to inform this driver that it should hangup
+ * the tty device (lower modem control lines after last process
+ * using tty devices closes the device or exited).
+ *
+ * Drop DTR/RTS if HUPCL is set. This causes any attached modem to
+ * hang up the line.
+ *
+ * On the receiving end, if CLOCAL bit is set, DCD will be ignored
+ * otherwise SIGHUP may be generated to indicate a line disconnect
+ * event.
+ */
+static void vs_hangup(struct tty_struct *tty)
+{
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	mutex_lock(&local_vsdev->lock);
+
+	/* Drops reference to tty */
+	tty_port_hangup(tty->port);
+
+	if (tty && C_HUPCL(tty))
+		vs_update_modem_lines(tty, 0, TIOCM_DTR | TIOCM_RTS);
+
+	mutex_unlock(&local_vsdev->lock);
+	pr_debug("hanged up!\n");
+}
+
+/*
+ * Return number of interrupts as response to TIOCGICOUNT IOCTL.
+ * Both 1->0 and 0->1 transitions are counted, except for RI;
+ * where only 0->1 transitions are accounted.
+ */
+static int vs_get_icount(struct tty_struct *tty,
+				struct serial_icounter_struct *icount)
+{
+	struct async_icount cnow;
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	mutex_lock(&local_vsdev->lock);
+	cnow = local_vsdev->icount;
+	mutex_unlock(&local_vsdev->lock);
+
+	icount->cts = cnow.cts;
+	icount->dsr = cnow.dsr;
+	icount->rng = cnow.rng;
+	icount->dcd = cnow.dcd;
+	icount->tx = cnow.tx;
+	icount->rx = cnow.rx;
+	icount->frame = cnow.frame;
+	icount->parity = cnow.parity;
+	icount->overrun = cnow.overrun;
+	icount->brk = cnow.brk;
+	icount->buf_overrun = cnow.buf_overrun;
+
+	return 0;
+}
+
+/*
+ * Invoked by tty layer to execute TCIOFF and TCION IOCTL commands
+ * generally because user space process called tcflow() function.
+ * It send a high priority character to the tty device end even if
+ * stopped.
+ *
+ * If this function (send_xchar) is defined by tty device driver,
+ * tty core will call this function. If it is not specified then
+ * tty core will first instruct this driver to start transmission
+ * (start()) and then invoke write() of this driver passing character
+ * to be written and then it will call stop() of this driver.
+ */
+static void vs_send_xchar(struct tty_struct *tty, char ch)
+{
+	int was_paused;
+	struct vs_dev *local_vsdev = db[tty->index].vsdev;
+
+	was_paused = local_vsdev->tx_paused;
+	if (was_paused)
+		local_vsdev->tx_paused = 0;
+
+	vs_put_char(tty, ch);
+	if (was_paused)
+		local_vsdev->tx_paused = 1;
+}
+
+/*
+ * Invoked by tty core in response to tcdrain() call. As this driver
+ * drains on write() itself, we return immediately from here.
+ */
+static void vs_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	pr_debug("returned wait until sent!\n");
+}
+
+/*
+ * Extract numerical number (index) from the given string
+ * from a particular offset.
+ */
+static int vs_get_given_idx(char const *data, int offset,
+				unsigned int *idx)
+{
+	int x;
+	char tmp[8];
+
+	memset(tmp, '\0', sizeof(tmp));
+	for (x = 0; x < 5; x++) {
+		tmp[x] = data[offset];
+		offset++;
+	}
+
+	return kstrtouint(tmp, 10, idx);
+}
+
+/*
+ * Returns next minor number (index) free to be used for
+ * next tty device otherwise -ENOMEM. If a particular index
+ * is to be excluded it is provided by the caller in 'exclude'.
+ */
+static int vs_get_free_idx(unsigned int *idx, int exclude)
+{
+	int x;
+
+	for (x = 0; x < max_num_vs_devs; x++) {
+		if (db[x].index == -1) {
+			if (x == exclude) {
+				continue;
+			} else {
+				*idx = x;
+				return 0;
+			}
+		}
+	}
+
+	return -ENOMEM;
+}
+
+/*
+ * Unregister tty device specified by minor number 'x'
+ * and remove sysfs files associate with it. Caller must
+ * hold card lock. First tty must be released and then port.
+ *
+ * It is common to reset environment before launching new test
+ * suite during automated testing. To support this we allow
+ * removing devices even when it was created using DT as of
+ * now till we find any string reason not do so.
+ */
+static void vs_del_single_dev(int x)
+{
+	struct tty_struct *tty;
+	struct vs_dev *vsdev;
+
+	vsdev = db[x].vsdev;
+	if (vsdev) {
+		sysfs_remove_group(&vsdev->device->kobj, &vs_info_attr_grp);
+		if (vsdev->own_tty && vsdev->own_tty->port) {
+			tty = tty_port_tty_get(vsdev->own_tty->port);
+			if (tty) {
+				tty_vhangup(tty);
+				tty_kref_put(tty);
+			}
+		}
+		tty_unregister_device(ttyvs_driver, db[x].index);
+	}
+}
+
+/*
+ * Destroy all tty devices created, mark all the indexes as
+ * available for use and reset number of devices accounting.
+ */
+static void vs_del_all_devs(void)
+{
+	int x;
+
+	mutex_lock(&card_lock);
+
+	for (x = 0; x < max_num_vs_devs; x++) {
+		if (db[x].index != -1)
+			vs_del_single_dev(x);
+	}
+
+	for (x = 0; x < max_num_vs_devs; x++) {
+		if (db[x].index != -1) {
+			kfree(db[x].vsdev);
+			db[x].index = -1;
+		}
+	}
+
+	total_nm_pair = 0;
+	total_lb_devs = 0;
+	last_lbdev_idx  = -1;
+	last_nmdev1_idx = -1;
+	last_nmdev2_idx = -1;
+
+	mutex_unlock(&card_lock);
+}
+
+/*
+ * Destroy a tty device specified by the given index. If this device
+ * is part of null modem pair then peer device is also destroyed.
+ */
+static int vs_del_specific_devs(const char *data)
+{
+	int x, y, ret;
+	unsigned int vdevidx;
+	struct vs_dev *vsdev;
+
+	mutex_lock(&card_lock);
+
+	ret = vs_get_given_idx(data, 4, &vdevidx);
+	if (ret)
+		return ret;
+
+	/* If the index is valid and device exist, delete it */
+	if ((vdevidx >= 0) && (vdevidx <= 65535) &&
+		(db[vdevidx].index != -1)) {
+
+		x = db[vdevidx].index;
+		vsdev = db[x].vsdev;
+
+		vs_del_single_dev(x);
+
+		y = -1;
+		if (vsdev->own_index != vsdev->peer_index) {
+			y = db[vsdev->peer_index].index;
+
+			vs_del_single_dev(y);
+			kfree(db[y].vsdev);
+
+			db[y].index = -1;
+			--total_nm_pair;
+		} else {
+			--total_lb_devs;
+		}
+
+		kfree(db[x].vsdev);
+		db[x].index = -1;
+	} else {
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&card_lock);
+
+	return ret;
+}
+
+/*
+ * Allocate per device private data (vsdev) for this driver, register
+ * with tty core and create custom sysfs nodes for emulating serial
+ * port events. Caller should hold card lock.
+ */
+static int vs_alloc_reg_one_dev(int oidx, int pidx, int rtsmap,
+			int dtrmap, int dtropn)
+{
+	int ret;
+	struct vs_dev *vsdev;
+	struct device *dev;
+
+	/* Allocate and init virtual tty device private data */
+	vsdev = kcalloc(1, sizeof(struct vs_dev), GFP_KERNEL);
+	if (!vsdev)
+		return -ENOMEM;
+
+	vsdev->own_tty = NULL;
+	vsdev->peer_tty = NULL;
+	vsdev->own_index = oidx;
+	vsdev->peer_index =  pidx;
+	vsdev->rts_mappings = rtsmap;
+	vsdev->dtr_mappings = dtrmap;
+	vsdev->set_odtr_at_open = dtropn;
+	vsdev->msr_reg = 0;
+	vsdev->mcr_reg = 0;
+	vsdev->waiting_msr_chg = 0;
+	vsdev->tx_paused = 0;
+	vsdev->faulty_cable = 0;
+	mutex_init(&vsdev->lock);
+
+	/* Register with tty core with specific minor number */
+	dev = tty_register_device(ttyvs_driver, oidx, NULL);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	vsdev->device = dev;
+	dev_set_drvdata(dev, vsdev);
+
+	/* Create custom sysfs files for this device for events */
+	ret = sysfs_create_group(&dev->kobj, &vs_info_attr_grp);
+	if (ret) {
+		tty_unregister_device(ttyvs_driver, oidx);
+		goto fail;
+	}
+
+	/* Claim this index in global database */
+	db[oidx].index = oidx;
+	db[oidx].vsdev = vsdev;
+
+	return 0;
+
+fail:
+	kfree(vsdev);
+	return ret;
+}
+
+/*
+ * Extract pin mappings from local to remote tty devices.
+ * The given 'data' is to be parsed starting from index 'x'.
+ * Returns 0 when pin is connected, negative value if an error
+ * happens, a positive value when pin mapping is found.
+ */
+static int vs_extract_pin_mapping(char const *data, int offset)
+{
+	int i, mapping = 0;
+
+	for (i = 0; i < 8; i++) {
+		switch (data[offset]) {
+		case '8':
+			mapping |= VS_CON_CTS;
+			break;
+		case '1':
+			mapping |= VS_CON_DCD;
+			break;
+		case '6':
+			mapping |= VS_CON_DSR;
+			break;
+		case '9':
+			mapping |= VS_CON_RI;
+			break;
+		case '#':
+			/* causes return from function */
+			i = 10;
+			break;
+		case 'x':
+		case ',':
+			break;
+		default:
+			return -EINVAL;
+		}
+		offset++;
+	}
+
+	return mapping;
+}
+
+static int vs_extract_dev_param_str(const char *data, unsigned int *idx,
+			int *rtsmap, int *dtrmap, int *dtratopen, int offset1,
+			int offset2, int offset3, int offset4, int exclude)
+{
+	int ret;
+
+	if (data[offset1] != 'x') {
+		ret = vs_get_given_idx(data, offset1, idx);
+		if (ret)
+			goto fail;
+		if (*idx >= max_num_vs_devs) {
+			ret = -EINVAL;
+			goto fail;
+		}
+		if (db[*idx].index != -1) {
+			ret = -EEXIST;
+			goto fail;
+		}
+	} else {
+		ret = vs_get_free_idx(idx, exclude);
+		if (ret)
+			goto fail;
+	}
+
+	*rtsmap = vs_extract_pin_mapping(data, offset2);
+	if (*rtsmap < 0) {
+		ret = *rtsmap;
+		goto fail;
+	}
+
+	*dtrmap = vs_extract_pin_mapping(data, offset3);
+	if (*dtrmap < 0) {
+		ret = *dtrmap;
+		goto fail;
+	}
+
+	*dtratopen = (data[offset4] == 'y') ? 1 : 0;
+
+	return 0;
+
+fail:
+	return ret;
+}
+
+static int vs_parse_dt_get_map(const struct device_node *np,
+				const char *prop, int *mapping)
+{
+	int x, ret, num_map;
+	int val[4];
+
+	/*
+	 * If the RTS/DTR pin is unconnected (property doesn't exist)
+	 * set mapping to 0 and return success.
+	 */
+	ret = of_property_count_u32_elems(np, prop);
+	if (ret < 0) {
+		if (ret == -EINVAL) {
+			*mapping = 0;
+			return 0;
+		}
+		return ret;
+	}
+
+	/*
+	 * A given pin can be connected to 1,6,8,9 pins. Therefore if
+	 * more then 4 mappings are defined in DT, ignore it.
+	 */
+	num_map = ret;
+	if (ret > 4)
+		num_map = 4;
+
+	ret = of_property_read_u32_array(np, prop, val, num_map);
+	if (ret < 0)
+		return ret;
+
+	*mapping = 0;
+	for (x = 0; x < num_map; x++) {
+		switch (val[x]) {
+		case 8:
+			*mapping |= VS_CON_CTS;
+			break;
+		case 1:
+			*mapping |= VS_CON_DCD;
+			break;
+		case 6:
+			*mapping |= VS_CON_DSR;
+			break;
+		case 9:
+			*mapping |= VS_CON_RI;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Extract index of device, RTS mappings, DTR mappings and
+ * whether to assert DTR at device open or not from device tree.
+ */
+static int vs_extract_dev_param_dt(const struct device_node *np,
+			unsigned int *idx, int *rtsmap, int *dtrmap,
+			int *dtratopen, int exclude)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "dev-num", idx);
+	if (ret) {
+		ret = vs_get_free_idx(idx, exclude);
+		if (ret)
+			return ret;
+	}
+
+	/* If the given index is already used, return error */
+	if (db[*idx].index != -1)
+		return -EEXIST;
+
+	ret = vs_parse_dt_get_map(np, "rtsmap", rtsmap);
+	if (ret)
+		return ret;
+
+	ret = vs_parse_dt_get_map(np, "dtrmap", dtrmap);
+	if (ret)
+		return ret;
+
+	*dtratopen = of_property_read_bool(np,
+						"set-dtr-at-open") ? 1 : 0;
+
+	return 0;
+}
+
+/*
+ * Create a loop-back style device:
+ * 0. Information about device parameters can come through either
+ *    pre-defined format string or device-tree node.
+ * 1. Decide index to use. If the number is specified by user, use
+ *    it, otherwise find next lowest index. If the given index is
+ *    used already through error.
+ * 2. Extract RTS and DTR mappings. A pin can map to pin numbers
+ *    1,6,8,9 only. Through error if invalid mapping is given.
+ * 3. Find if DTR should be asserted when tty device is opened or
+ *    not.
+ * 4. Allocate and initialize 'struct vs_dev' instance with info
+ *    from steps 1,2 & 3.
+ * 5. Register one tty device with tty core and associate this tty
+ *    device with this vsdev instance.
+ * 6. Create custom sysfs nodes to emulate serial port events for
+ *    this device.
+ * 7. Increase total_lb_devs global counter for tracking purpose.
+ * 8. Save this current index as last loop-back device's index.
+ */
+static int vs_add_lb(const char *data, const struct device_node *np)
+{
+	int ret, rtsmap, dtrmap, dtratopen;
+	unsigned int idx;
+
+	mutex_lock(&card_lock);
+
+	if (data) {
+		ret = vs_extract_dev_param_str(data, &idx, &rtsmap,
+					&dtrmap, &dtratopen, 6, 20, 30, 58, -1);
+		if (ret)
+			goto fail;
+	} else {
+		ret = vs_extract_dev_param_dt(np, &idx, &rtsmap,
+					&dtrmap, &dtratopen, -1);
+		if (ret)
+			goto fail;
+	}
+
+	ret = vs_alloc_reg_one_dev(idx, idx, rtsmap, dtrmap, dtratopen);
+	if (ret)
+		goto fail;
+
+	++total_lb_devs;
+	last_lbdev_idx = idx;
+
+fail:
+	mutex_unlock(&card_lock);
+	return ret;
+}
+
+/*
+ * Create a null-modem style pair of devices:
+ * Steps are same as for creating loop-back style device except;
+ * 1. Availability of both the indexs are checked before creating
+ *    devices.
+ * 2. Global counter total_nm_pair is increased.
+ */
+static int vs_add_nm(const char *data, const struct device_node *np1,
+				const struct device_node *np2)
+{
+	int ret, rtsmap1, dtrmap1, dtratopen1;
+	int rtsmap2, dtrmap2, dtratopen2;
+	unsigned int idx1, idx2;
+
+	mutex_lock(&card_lock);
+
+	if (data) {
+		ret = vs_extract_dev_param_str(data, &idx1, &rtsmap1, &dtrmap1,
+				&dtratopen1, 6, 20, 30, 58, -1);
+		if (ret)
+			goto fail;
+
+		ret = vs_extract_dev_param_str(data, &idx2, &rtsmap2, &dtrmap2,
+				&dtratopen2, 12, 40, 50, 60, idx1);
+		if (ret)
+			goto fail;
+	} else {
+		ret = vs_extract_dev_param_dt(np1, &idx1, &rtsmap1,
+					&dtrmap1, &dtratopen1, -1);
+		if (ret)
+			goto fail;
+		ret = vs_extract_dev_param_dt(np2, &idx2, &rtsmap2,
+					&dtrmap2, &dtratopen2, idx1);
+		if (ret)
+			goto fail;
+	}
+
+	ret = vs_alloc_reg_one_dev(idx1, idx2, rtsmap1, dtrmap1, dtratopen1);
+	if (ret)
+		goto fail;
+
+	ret = vs_alloc_reg_one_dev(idx2, idx1, rtsmap2, dtrmap2, dtratopen2);
+	if (ret)
+		goto fail;
+
+	++total_nm_pair;
+	last_nmdev1_idx = idx1;
+	last_nmdev2_idx = idx2;
+
+fail:
+	mutex_unlock(&card_lock);
+	return ret;
+}
+
+/*
+ * Decide we need to create or destroy virtual device and invoke
+ * the corresponding action. User space writes a pre-formatted string
+ * to the device node /dev/ttyvs_card and this function gets called.
+ *
+ * 1. String to create null modem using next free indexes:
+ * "gennm#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y"
+ *
+ * 2. String to create null modem (for ex; ttyvs2 <--> ttyvs3)
+ * "gennm#00002#00003#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y"
+ *
+ * 3. String to create standard loopback device
+ * "genlb#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#x-x,x,x,x#x-x,x,x,x#y#x"
+ *
+ * 4. String to delete all devices
+ * "del#xxxxx#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
+ *
+ * 5. String to delete device given by number (for ex; ttyvs5)
+ * "del#00005#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
+ */
+static ssize_t vs_card_write(struct file *file,
+			const char __user *buf, size_t length, loff_t *ppos)
+{
+	char data[64];
+	int ret;
+
+	if ((length > 60 && length < 63) && buf) {
+		if (copy_from_user(data, buf, length) != 0)
+			return -EFAULT;
+		data[62] = '\0';
+	} else {
+		return -EINVAL;
+	}
+
+	ret = 0;
+	if (strncmp(data, "genlb#", 6) == 0)
+		ret = vs_add_lb(data, NULL);
+	else if (strncmp(data, "gennm#", 6) == 0)
+		ret = vs_add_nm(data, NULL, NULL);
+	else if (strncmp(data, "del#xxxxx#", 10) == 0)
+		vs_del_all_devs();
+	else if (strncmp(data, "del#", 4) == 0 && data[8] != 'x')
+		ret = vs_del_specific_devs(data);
+	else
+		return -EINVAL;
+
+	if (ret)
+		return ret;
+
+	return length;
+}
+
+/*
+ * Gives next available free index and last used index for device(s)
+ * created. From the shell we can run command:
+ * $ head -c 52 /dev/ttyvs_card
+ *
+ * This is mainly used by GUI application. Application displays a
+ * device (for ex; /dev/ttyvs6) in drop down menu, user selects it
+ * and clock on create and device is created.
+ *
+ * Similarly, user selects a null modem pair and their connections
+ * are shown graphically. So instead of application issuing multiple
+ * reads to driver, it can get all info in single read through this
+ * function.
+ */
+static ssize_t vs_card_read(struct file *file,
+				char __user *buf, size_t size, loff_t *ppos)
+{
+	int x, ret, val;
+	char data[64];
+	int first_avail_idx = -1;
+	int second_avail_idx = -1;
+	struct vs_dev *lbvsdev = NULL;
+	struct vs_dev *nm1vsdev = NULL;
+	struct vs_dev *nm2vsdev = NULL;
+
+	memset(data, '\0', 64);
+
+	if (size != 52)
+		return -EINVAL;
+
+	mutex_lock(&card_lock);
+
+	/* Find next available free index */
+	for (x = 0; x < max_num_vs_devs; x++) {
+		if (db[x].index == -1) {
+			if (first_avail_idx == -1) {
+				first_avail_idx = x;
+			} else {
+				second_avail_idx = x;
+				break;
+			}
+		}
+	}
+
+	if ((first_avail_idx != -1) && (second_avail_idx != -1))
+		val = 2;
+	else if ((first_avail_idx != -1) && (second_avail_idx == -1))
+		val = 1;
+	else if ((first_avail_idx == -1) && (second_avail_idx == -1))
+		val = 0;
+
+	if (last_lbdev_idx == -1) {
+		if (last_nmdev1_idx == -1) {
+			snprintf(data, 64,
+				"xxxxx#xxxxx-xxxxx#%05d-%05d#%d#x-x#x-x#x-x#x#x#x\r\n",
+				first_avail_idx, second_avail_idx, val);
+		} else {
+			nm1vsdev = db[last_nmdev1_idx].vsdev;
+			nm2vsdev = db[last_nmdev2_idx].vsdev;
+			snprintf(data, 64,
+				"xxxxx#%05d-%05d#%05d-%05d#%d#x-x#%d-%d#%d-%d#x#%d#%d\r\n",
+				last_nmdev1_idx, last_nmdev2_idx,
+				first_avail_idx, second_avail_idx,
+				val, nm1vsdev->rts_mappings,
+				nm1vsdev->dtr_mappings,
+				nm2vsdev->rts_mappings,
+				nm2vsdev->dtr_mappings,
+				nm1vsdev->set_odtr_at_open,
+				nm2vsdev->set_odtr_at_open);
+		}
+	} else {
+		if (last_nmdev1_idx == -1) {
+			lbvsdev = db[last_lbdev_idx].vsdev;
+			snprintf(data, 64,
+				"%05d#xxxxx-xxxxx#%05d-%05d#%d#%d-%d#x-x#x-x#%d#x#x\r\n",
+				last_lbdev_idx, first_avail_idx,
+				second_avail_idx, val,
+				lbvsdev->rts_mappings,
+				lbvsdev->dtr_mappings,
+				lbvsdev->set_odtr_at_open);
+		} else {
+			lbvsdev = db[last_lbdev_idx].vsdev;
+			nm1vsdev = db[last_nmdev1_idx].vsdev;
+			nm2vsdev = db[last_nmdev2_idx].vsdev;
+			snprintf(data, 64,
+				"%05d#%05d-%05d#%05d-%05d#%d#%d-%d#%d-%d#%d-%d#%d#%d#%d\r\n",
+				last_lbdev_idx, last_nmdev1_idx,
+				last_nmdev2_idx, first_avail_idx,
+				second_avail_idx,
+				val, lbvsdev->rts_mappings,
+				lbvsdev->dtr_mappings,
+				nm1vsdev->rts_mappings,
+				nm1vsdev->dtr_mappings,
+				nm2vsdev->rts_mappings,
+				nm2vsdev->dtr_mappings,
+				lbvsdev->set_odtr_at_open,
+				nm1vsdev->set_odtr_at_open,
+				nm2vsdev->set_odtr_at_open);
+		}
+	}
+
+	mutex_unlock(&card_lock);
+
+	ret = copy_to_user(buf, &data, 52);
+	if (ret)
+		return -EFAULT;
+
+	return 52;
+}
+
+/* Always return success as we don't have anything needed here */
+static int vs_card_open(struct inode *inode, struct  file *file)
+{
+	return 0;
+}
+static int vs_card_close(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static const struct tty_operations vs_serial_ops = {
+	.install	     = vs_install,
+	.cleanup	     = vs_cleanup,
+	.open	         = vs_open,
+	.close	         = vs_close,
+	.write	         = vs_write,
+	.put_char	     = vs_put_char,
+	.flush_chars     = vs_flush_chars,
+	.write_room      = vs_write_room,
+	.chars_in_buffer = vs_chars_in_buffer,
+	.ioctl	         = vs_ioctl,
+	.set_termios     = vs_set_termios,
+	.throttle	     = vs_throttle,
+	.unthrottle      = vs_unthrottle,
+	.stop	         = vs_stop,
+	.start	         = vs_start,
+	.hangup	         = vs_hangup,
+	.break_ctl       = vs_break_ctl,
+	.flush_buffer    = vs_flush_buffer,
+	.wait_until_sent = vs_wait_until_sent,
+	.send_xchar      = vs_send_xchar,
+	.tiocmget	     = vs_tiocmget,
+	.tiocmset	     = vs_tiocmset,
+	.get_icount      = vs_get_icount,
+};
+
+static const struct file_operations vs_vcard_fops = {
+	.owner   = THIS_MODULE,
+	.open    = vs_card_open,
+	.release = vs_card_close,
+	.read    = vs_card_read,
+	.write   = vs_card_write,
+};
+
+static struct miscdevice ttyvs_card_dev = {
+	.minor = 0,
+	.name  = "ttyvs_card",
+	.fops  = &vs_vcard_fops,
+};
+
+static int vs_reg_driver_and_init_db(void)
+{
+	int x, ret;
+
+	/* Initialize and register this driver with tty core */
+	ttyvs_driver = tty_alloc_driver(max_num_vs_devs, 0);
+	if (IS_ERR(ttyvs_driver))
+		return PTR_ERR(ttyvs_driver);
+
+	ttyvs_driver->owner = THIS_MODULE;
+	ttyvs_driver->driver_name = "ttyvs";
+	ttyvs_driver->name = "ttyvs";
+	ttyvs_driver->major = 0;
+	ttyvs_driver->minor_start = 0;
+	ttyvs_driver->type = TTY_DRIVER_TYPE_SERIAL;
+	ttyvs_driver->subtype = SERIAL_TYPE_NORMAL;
+	ttyvs_driver->flags = TTY_DRIVER_REAL_RAW
+				| TTY_DRIVER_RESET_TERMIOS
+				| TTY_DRIVER_DYNAMIC_DEV;
+	ttyvs_driver->init_termios = tty_std_termios;
+	ttyvs_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL;
+	ttyvs_driver->init_termios.c_ispeed = 9600;
+	ttyvs_driver->init_termios.c_ospeed = 9600;
+
+	tty_set_operations(ttyvs_driver, &vs_serial_ops);
+
+	ret = tty_register_driver(ttyvs_driver);
+	if (ret)
+		goto fail_reg;
+
+	/*
+	 * Allocate memory for database for the number of devices to be
+	 * supported.
+	 */
+	db = kcalloc(max_num_vs_devs, sizeof(struct vs_info), GFP_KERNEL);
+	if (!db) {
+		ret = -ENOMEM;
+		goto fail_db;
+	}
+
+	/*
+	 * Mark all indexes as available for use.
+	 * A value of -1 at particular index (db[X].index) means that
+	 * index is available to install new tty device.
+	 */
+	for (x = 0; x < max_num_vs_devs;  x++)
+		db[x].index = -1;
+
+	return 0;
+
+fail_db:
+	tty_unregister_driver(ttyvs_driver);
+fail_reg:
+	put_tty_driver(ttyvs_driver);
+	return ret;
+}
+
+/*
+ * Information passed through device tree is given more preference
+ * then through module params. This parses all device nodes and
+ * creates loop-back and null-modem ttyvsX devices in the process.
+ */
+static int ttyvs_device_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 max_num;
+	struct device_node *child, *peer_node;
+	phandle peer;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	/* If any device was created during module_init, delete it */
+	if (total_nm_pair || total_lb_devs)
+		vs_del_all_devs();
+
+	/*
+	 * We register with tty core again only if maximum number of
+	 * devices registered during module_init is changed by device
+	 * tree.
+	 */
+	max_num = 0;
+	ret = of_property_read_u32(np, "max-num-vs-devs", &max_num);
+	if (max_num != max_num_vs_devs) {
+		tty_unregister_driver(ttyvs_driver);
+		put_tty_driver(ttyvs_driver);
+		kfree(db);
+
+		max_num_vs_devs = max_num;
+		ret = vs_reg_driver_and_init_db();
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * If we fail to create any device emit error log and move to the
+	 * next device tree node.
+	 */
+	for_each_available_child_of_node(np, child) {
+		if (of_node_test_and_set_flag(child, OF_POPULATED))
+			continue;
+
+		if (of_property_read_u32(child, "peer-dev", &peer)) {
+			ret = vs_add_lb(NULL, child);
+			if (ret) {
+				pr_err("can't create lb %s %d\n",
+						child->name, ret);
+				continue;
+			}
+		} else {
+			peer_node = of_find_node_by_phandle(peer);
+			if (peer_node) {
+				of_node_set_flag(peer_node, OF_POPULATED);
+				ret = vs_add_nm(NULL, child, peer_node);
+				if (ret) {
+					pr_err("can't create nm %s <-> %s %d\n",
+						child->name, peer_node->name,
+						ret);
+					continue;
+				}
+			} else {
+				pr_err("can't find peer for %s %d\n",
+						child->name, ret);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ttyvs_dev_match_tbl[] = {
+	{ .compatible = "ttyvs,virtual-uart-card" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ttyvs_dev_match_tbl);
+
+static struct platform_driver ttyvs_platform_drv = {
+	.probe		= ttyvs_device_probe,
+	.driver		= {
+		.name	= "ttyvs",
+		.of_match_table = ttyvs_dev_match_tbl,
+	},
+};
+
+static int __init ttyvs_init(void)
+{
+	int x, ret;
+
+	char *lbcmd =
+		"genlb#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#x-x,x,x,x#x-x,x,x,x#y#x";
+	char *nmcmd =
+		"gennm#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y";
+
+	ret = vs_reg_driver_and_init_db();
+	if (ret)
+		return ret;
+
+	/*
+	 * If module was loaded with parameters supplied, create null-modem
+	 * and loopback virtual tty devices as specified.
+	 */
+	if (((2 * init_num_nm_pairs) + init_num_lb_devs) <= max_num_vs_devs) {
+		for (x = 0; x < init_num_nm_pairs; x++) {
+			ret = vs_add_nm(nmcmd, NULL, NULL);
+			if (ret < 0)
+				goto fail_devs;
+		}
+		for (x = 0; x < init_num_lb_devs; x++) {
+			ret = vs_add_lb(lbcmd, NULL);
+			if (ret < 0)
+				goto fail_devs;
+		}
+	} else {
+		pr_err("specified devices not created - invalid total\n");
+	}
+
+	/*
+	 * Application should read/write to /dev/ttyvs_card to
+	 * create/destroy tty device and query information associated
+	 * with them.
+	 */
+	ret = misc_register(&ttyvs_card_dev);
+	if (ret)
+		goto fail_devs;
+
+	/* Register as platform driver to handle device tree nodes */
+	ret = platform_driver_register(&ttyvs_platform_drv);
+	if (ret)
+		goto fail_card;
+
+	pr_info("serial port null modem emulation driver\n");
+	return 0;
+
+fail_card:
+	misc_deregister(&ttyvs_card_dev);
+fail_devs:
+	vs_del_all_devs();
+	kfree(db);
+	tty_unregister_driver(ttyvs_driver);
+	put_tty_driver(ttyvs_driver);
+	return ret;
+}
+
+static void __exit ttyvs_exit(void)
+{
+	platform_driver_unregister(&ttyvs_platform_drv);
+	misc_deregister(&ttyvs_card_dev);
+
+	vs_del_all_devs();
+	kfree(db);
+
+	tty_unregister_driver(ttyvs_driver);
+	put_tty_driver(ttyvs_driver);
+}
+
+module_init(ttyvs_init);
+module_exit(ttyvs_exit);
+
+/*
+ * By default this driver supports upto 64 virtual devices. This
+ * can be overridden through max_num_vs_devs module parameter or
+ * through 'max-num-vs-devs' device tree property. For ex; to
+ * support upto 256 devices, load this driver like this:
+ * $ insmod ./ttyvs.ko max_num_vs_devs=256
+ */
+module_param(max_num_vs_devs, ushort, 0);
+MODULE_PARM_DESC(max_num_vs_devs,
+		"Maximum virtual tty devices to be supported");
+
+/*
+ * Specifies number of standard null modem pairs to be created
+ * when this driver is loaded. If both null modem and loopback
+ * devices are to be created, first all null modem devices will
+ * be created and then all loopback devices.
+ */
+module_param(init_num_nm_pairs, ushort, 0);
+MODULE_PARM_DESC(init_num_nm_pairs,
+		"Standard null modem pairs to create initially");
+
+/*
+ * Specifies number of standard loopback devices to be created
+ * during driver loading itself.
+ */
+module_param(init_num_lb_devs, ushort, 0);
+MODULE_PARM_DESC(init_num_lb_devs,
+		"Standard loopback devices to create initially");
+
+MODULE_AUTHOR("Rishi Gupta <gupt21@gmail.com>");
+MODULE_DESCRIPTION("Serial port null modem emulation driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

