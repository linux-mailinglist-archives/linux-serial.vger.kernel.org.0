Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A633A52F
	for <lists+linux-serial@lfdr.de>; Sun,  9 Jun 2019 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfFILuq (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sun, 9 Jun 2019 07:50:46 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:42323 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbfFILuq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 9 Jun 2019 07:50:46 -0400
Received: by mail-ed1-f44.google.com with SMTP id z25so9727988edq.9
        for <linux-serial@vger.kernel.org>; Sun, 09 Jun 2019 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UYvqnbxrPZ1Lps6sz2SegnWqDlr9WZObAh41cn4G5xc=;
        b=dVkjGPBUrK5SX4JArQQHXG8vUIT5G7qt4KY7Wj4BhQSnM5OMtdHNh2Kf/dCVx3LBoF
         mkXvC4bpJEb2BNuY/f5CIfnvitTDYY8s4s7Qse9snyjG3dNDjiw8B5WEk75YiyrnQQHn
         v4G5vxyxeEkrzG7leMx0aRKII0QtmIn6810qyhkUy2d2A71NOg1qM9PuH8tCMXIRpKQE
         uVXqwpFb6wWjldxp8XCoQtLSOXPZHgKk2a28DBgjf93PQI7z4nHh/jWYoRFvSwS2yNhS
         qUQ4VHWye134gMvs0gxBVu3RzKyrrp3Q1P4LhmHB+PyhwgBmptXmJKFtgIqwiIvuIqDk
         4x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UYvqnbxrPZ1Lps6sz2SegnWqDlr9WZObAh41cn4G5xc=;
        b=h0Phr9F/riZra13lzg/IPr3DPGXJqYdxbkDs53konUyXw7byl4Rt/ChR+qznuBttrh
         fBgcb7MaxkRNPFzmH+makFpQ2duEynmgsy4IX5jcOMKAdWMARu2On8vVs/l5FGwohP12
         Mhtd96zSzM6o7PZXEVs6EyiDgjbOU5mQBShJB0V7nC8PS3HewuHz1nGVEFhSoGOiUX8F
         NGzvMzybhh5D0B4HA494zqq6w10EJFTw7ac2cIcXEoCSXJ7GJRtZZ6jadFxZktrKuB57
         IW8/qQ8fcuUzDbdPfDYIwPjI5S7dYkyqcuJTi4G+3Zzl9eAYTElvoqA+2BcJLn4UDhwG
         sfIA==
X-Gm-Message-State: APjAAAW9UNJN7DWRkk87xRHYTYg6MvVWxRTR1SuXUaeGDNyQDYIpo5G8
        9A7P71l4awFgou/hc2/yCxXhH03IdFqRdebkN3jxYbOC
X-Google-Smtp-Source: APXvYqww+Yc+Yn02Q4QVOUoieuCi0Wf0E/PEoILcL9GzTUQD8c0iGReDD+tDNwcJ0bj5hI2qQiYPBALBrFI0djvwljE=
X-Received: by 2002:a50:ac46:: with SMTP id w6mr33964240edc.238.1560081044247;
 Sun, 09 Jun 2019 04:50:44 -0700 (PDT)
MIME-Version: 1.0
From:   Oliver Barta <o.barta89@gmail.com>
Date:   Sun, 9 Jun 2019 13:50:28 +0200
Message-ID: <CALJK04N=v9DQKkdL2cwrRmObWTHMikkv2vhV-eqrt_-J4tpLAg@mail.gmail.com>
Subject: serial: 8250: Potential loss of transmission error information in serial8250_handle_irq
To:     linux-serial@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

there is a small issue in serial8250_handle_irq function.

    status = serial_port_in(port, UART_LSR);

    if (status & (UART_LSR_DR | UART_LSR_BI) &&
        iir & UART_IIR_RDI) {
        if (!up->dma || handle_rx_dma(up, iir))
            status = serial8250_rx_chars(up, status);
    }

The line status register is read unconditionally but the contained
error flags are processed only if UART_IIR_RDI bit is set in iir
variable which was updated by a read of the interrupt identification
register which happened before the read of LSR. It is unlikely but
under certain timing conditions (steps for testing below) it may
happen that some error flags are set while the UART_IIR_RDI bit is
cleared in iir variable. In this case the error information (e.g.
framing error or parity error) obtained from LSR will be lost as the
bits in the hardware register are cleared by the read.


This problem was introduced by commit

2e9fe539108320820016f78ca7704a7342788380 serial: 8250: Don't service
RX FIFO if interrupts are disabled

I see two possible solutions, either reverting this change or saving
the error flags with

up->lsr_saved_flags |= status & LSR_SAVE_FLAGS;

in case they are not processed right away as done at several other
places. I would vote for reverting it but I would like to hear a
second opinion first.


The commit message explains that the original change was required
because some OMAP UART driver disables UART RX FIFO interrupts as
response to a throttling request and it needs to be ensured that UART
RX FIFO processing is actually stopped if the corresponding interrupts
are disabled. I'm not sure if this is the right way to handle a
throttling request. Based on the documentation in Documentation/serial
I would expect a throttling request to only trigger hardware flow
control to inform the sender that it should stop sending data. It
should be the responsibility of the sender to act accordingly.
Stopping processing of the input FIFO seems problematic to me as this
FIFO is typically small and will likely overflow if input processing
is stopped immediately.


Steps to trigger this issue:
1) Send a data packet which is larger than the TX FIFO.
2) Trigger an external function generator on the outgoing data packet
which is programmed to send a character with a parity error with a
specific delay relative to the outgoing packet so that the character
is received while the UART_IIR_THRI interrupt is processed in order to
reload the TX FIFO. In particular it needs to be received between the
read of IIR and LSR. (During my testing I added a delay of several
micro seconds between both read operations to increase the probability
for this to happen.)
3) Check if parity error information was properly processed.

I was testing on an Intel SOC with integrated DesignWare 16550A
compatible UART without DMA support.

Best regards,
Oliver Barta
