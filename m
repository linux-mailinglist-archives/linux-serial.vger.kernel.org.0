Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B725368D6
	for <lists+linux-serial@lfdr.de>; Sat, 28 May 2022 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiE0Wgp (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 27 May 2022 18:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354779AbiE0Wgo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 May 2022 18:36:44 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F724BE4;
        Fri, 27 May 2022 15:36:42 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id 2AB56374022D; Fri, 27 May 2022 22:27:28 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH 5/6] USB: serial: ftdi_sio: pass port to quirk port_probe
 functions
Message-Id: <20220527222728.2AB56374022D@freecalypso.org>
Date:   Fri, 27 May 2022 22:27:28 +0000 (UTC)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The original code passed only the pointer to the ftdi_private struct
to quirk port_probe functions.  However, some quirks may need to be
applied conditionally only to some channels of a multichannel FT2232x
or FT4232H device, and if a given quirk's port_probe function needs
to figure out which channel of a multichannel device is currently
being considered, it needs access to the port pointer passed to the
ftdi_sio_port_probe() function, so it can traverse USB data structures
from there.

Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
---
 drivers/usb/serial/ftdi_sio.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 49c08f07c969..6523a36dcc45 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -88,15 +88,15 @@ struct ftdi_private {
 struct ftdi_sio_quirk {
 	int (*probe)(struct usb_serial *);
 	/* Special settings for probed ports. */
-	void (*port_probe)(struct ftdi_private *);
+	void (*port_probe)(struct usb_serial_port *);
 };
 
 static int   ftdi_jtag_probe(struct usb_serial *serial);
 static int   ftdi_NDI_device_setup(struct usb_serial *serial);
 static int   ftdi_stmclite_probe(struct usb_serial *serial);
 static int   ftdi_8u2232c_probe(struct usb_serial *serial);
-static void  ftdi_USB_UIRT_setup(struct ftdi_private *priv);
-static void  ftdi_HE_TIRA1_setup(struct ftdi_private *priv);
+static void  ftdi_USB_UIRT_setup(struct usb_serial_port *port);
+static void  ftdi_HE_TIRA1_setup(struct usb_serial_port *port);
 
 static const struct ftdi_sio_quirk ftdi_jtag_quirk = {
 	.probe	= ftdi_jtag_probe,
@@ -2238,11 +2238,11 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->cfg_lock);
 
-	if (quirk && quirk->port_probe)
-		quirk->port_probe(priv);
-
 	usb_set_serial_port_data(port, priv);
 
+	if (quirk && quirk->port_probe)
+		quirk->port_probe(port);
+
 	ftdi_determine_type(port);
 	ftdi_set_max_packet_size(port);
 	if (read_latency_timer(port) < 0)
@@ -2263,8 +2263,10 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 /* Setup for the USB-UIRT device, which requires hardwired
  * baudrate (38400 gets mapped to 312500) */
 /* Called from usbserial:serial_probe */
-static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
+static void ftdi_USB_UIRT_setup(struct usb_serial_port *port)
 {
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
 	priv->flags |= ASYNC_SPD_CUST;
 	priv->custom_divisor = 77;
 	priv->force_baud = 38400;
@@ -2273,8 +2275,10 @@ static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
 /* Setup for the HE-TIRA1 device, which requires hardwired
  * baudrate (38400 gets mapped to 100000) and RTS-CTS enabled.  */
 
-static void ftdi_HE_TIRA1_setup(struct ftdi_private *priv)
+static void ftdi_HE_TIRA1_setup(struct usb_serial_port *port)
 {
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
 	priv->flags |= ASYNC_SPD_CUST;
 	priv->custom_divisor = 240;
 	priv->force_baud = 38400;
-- 
2.9.0

