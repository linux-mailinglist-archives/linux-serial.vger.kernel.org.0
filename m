Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50F1003F8
	for <lists+linux-serial@lfdr.de>; Mon, 18 Nov 2019 12:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKRLZc (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 18 Nov 2019 06:25:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfKRLYN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so19021330wrr.0
        for <linux-serial@vger.kernel.org>; Mon, 18 Nov 2019 03:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hS3pT5hJRUv2sQ4gkA9yffpuVvSl9rsKjuV5JcyqFr4=;
        b=jTi0G9cchAm7Klt5pjF99pIV30vF+jCvyp3wX3zcIf8/oZT61ArtHAt4ryVM7LNTUk
         JzrAlwS2K83gNoGVWC1JeduHRayjcL3+h/pnQht8nuEbdbBt4m6OpCz2OnJkL3u0NKe3
         WQ8CIruLjAa/YQrDKyMEMSvcMmfcKirsS0+PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hS3pT5hJRUv2sQ4gkA9yffpuVvSl9rsKjuV5JcyqFr4=;
        b=uG4U3P4e11op96w2gj9KipD1Dy6w7fuOheSO6trBKEgZRcqThoDZUW8wwy3fDvUbfg
         jXjfNpfnP01Xgc+NhfGP75MnD1DW+FwjVKVxr7RWUlP5ow6mpxlKDMqQLf+bqOF4HyVn
         dRVAIenvoWmTKj/qF4q2hmTbtPbntR7AOxAX91C9b6tiglwwLexHc1D3/xyNZ2jEFP+K
         OeRBcxdTmaFdGz8O3VSXqAu9k7w9rwOw9PIir4vBSpHCPWK5Fj4a8EmhLQep1twnO8X7
         Qq76BVyTeuOUrvo5RPbi9wjnHBfCcv95rxol+pccCxRWsYd/B/h43Scz5hceSKmpvCIN
         Xf8Q==
X-Gm-Message-State: APjAAAVBtDIXMVaXgBkzV1Uaiv8KH0y2Nu0e+De3DGVCamEb5IY9j8Ys
        b/6/vAIMF6s20KVZKppTJyezgA==
X-Google-Smtp-Source: APXvYqwCQG4KHsVXlihG330qQtczhDjU6t4cdSAI9EXOIUEw8nCJuToFdPeqU1xxnuM8hdsZiCkOAg==
X-Received: by 2002:a5d:4b86:: with SMTP id b6mr22997009wrt.143.1574076248908;
        Mon, 18 Nov 2019 03:24:08 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:08 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 29/48] serial: ucc_uart: replace ppc-specific IO accessors
Date:   Mon, 18 Nov 2019 12:23:05 +0100
Message-Id: <20191118112324.22725-30-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some ARM-based SOCs (e.g. LS1021A) also have a QUICC engine. As
preparation for allowing this driver to build on ARM, replace the
ppc-specific in_be16() etc. by the qe_io* helpers. Done via
coccinelle.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 210 +++++++++++++++++-----------------
 1 file changed, 102 insertions(+), 108 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 7e802616cba8..8a378ee5d34f 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -258,11 +258,11 @@ static unsigned int qe_uart_tx_empty(struct uart_port *port)
 	struct qe_bd *bdp = qe_port->tx_bd_base;
 
 	while (1) {
-		if (in_be16(&bdp->status) & BD_SC_READY)
+		if (qe_ioread16be(&bdp->status) & BD_SC_READY)
 			/* This BD is not done, so return "not done" */
 			return 0;
 
-		if (in_be16(&bdp->status) & BD_SC_WRAP)
+		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
 			/*
 			 * This BD is done and it's the last one, so return
 			 * "done"
@@ -308,7 +308,7 @@ static void qe_uart_stop_tx(struct uart_port *port)
 	struct uart_qe_port *qe_port =
 		container_of(port, struct uart_qe_port, port);
 
-	clrbits16(&qe_port->uccp->uccm, UCC_UART_UCCE_TX);
+	qe_clrbits_be16(&qe_port->uccp->uccm, UCC_UART_UCCE_TX);
 }
 
 /*
@@ -343,10 +343,10 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 		p = qe2cpu_addr(bdp->buf, qe_port);
 
 		*p++ = port->x_char;
-		out_be16(&bdp->length, 1);
-		setbits16(&bdp->status, BD_SC_READY);
+		qe_iowrite16be(1, &bdp->length);
+		qe_setbits_be16(&bdp->status, BD_SC_READY);
 		/* Get next BD. */
-		if (in_be16(&bdp->status) & BD_SC_WRAP)
+		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
 			bdp = qe_port->tx_bd_base;
 		else
 			bdp++;
@@ -365,7 +365,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 	/* Pick next descriptor and fill from buffer */
 	bdp = qe_port->tx_cur;
 
-	while (!(in_be16(&bdp->status) & BD_SC_READY) &&
+	while (!(qe_ioread16be(&bdp->status) & BD_SC_READY) &&
 	       (xmit->tail != xmit->head)) {
 		count = 0;
 		p = qe2cpu_addr(bdp->buf, qe_port);
@@ -378,11 +378,11 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 				break;
 		}
 
-		out_be16(&bdp->length, count);
-		setbits16(&bdp->status, BD_SC_READY);
+		qe_iowrite16be(count, &bdp->length);
+		qe_setbits_be16(&bdp->status, BD_SC_READY);
 
 		/* Get next BD. */
-		if (in_be16(&bdp->status) & BD_SC_WRAP)
+		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
 			bdp = qe_port->tx_bd_base;
 		else
 			bdp++;
@@ -415,12 +415,12 @@ static void qe_uart_start_tx(struct uart_port *port)
 		container_of(port, struct uart_qe_port, port);
 
 	/* If we currently are transmitting, then just return */
-	if (in_be16(&qe_port->uccp->uccm) & UCC_UART_UCCE_TX)
+	if (qe_ioread16be(&qe_port->uccp->uccm) & UCC_UART_UCCE_TX)
 		return;
 
 	/* Otherwise, pump the port and start transmission */
 	if (qe_uart_tx_pump(qe_port))
-		setbits16(&qe_port->uccp->uccm, UCC_UART_UCCE_TX);
+		qe_setbits_be16(&qe_port->uccp->uccm, UCC_UART_UCCE_TX);
 }
 
 /*
@@ -431,7 +431,7 @@ static void qe_uart_stop_rx(struct uart_port *port)
 	struct uart_qe_port *qe_port =
 		container_of(port, struct uart_qe_port, port);
 
-	clrbits16(&qe_port->uccp->uccm, UCC_UART_UCCE_RX);
+	qe_clrbits_be16(&qe_port->uccp->uccm, UCC_UART_UCCE_RX);
 }
 
 /* Start or stop sending  break signal
@@ -470,14 +470,14 @@ static void qe_uart_int_rx(struct uart_qe_port *qe_port)
 	 */
 	bdp = qe_port->rx_cur;
 	while (1) {
-		status = in_be16(&bdp->status);
+		status = qe_ioread16be(&bdp->status);
 
 		/* If this one is empty, then we assume we've read them all */
 		if (status & BD_SC_EMPTY)
 			break;
 
 		/* get number of characters, and check space in RX buffer */
-		i = in_be16(&bdp->length);
+		i = qe_ioread16be(&bdp->length);
 
 		/* If we don't have enough room in RX buffer for the entire BD,
 		 * then we try later, which will be the next RX interrupt.
@@ -508,9 +508,10 @@ static void qe_uart_int_rx(struct uart_qe_port *qe_port)
 		}
 
 		/* This BD is ready to be used again. Clear status. get next */
-		clrsetbits_be16(&bdp->status, BD_SC_BR | BD_SC_FR | BD_SC_PR |
-			BD_SC_OV | BD_SC_ID, BD_SC_EMPTY);
-		if (in_be16(&bdp->status) & BD_SC_WRAP)
+		qe_clrsetbits_be16(&bdp->status,
+				   BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV | BD_SC_ID,
+				   BD_SC_EMPTY);
+		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
 			bdp = qe_port->rx_bd_base;
 		else
 			bdp++;
@@ -569,8 +570,8 @@ static irqreturn_t qe_uart_int(int irq, void *data)
 	u16 events;
 
 	/* Clear the interrupts */
-	events = in_be16(&uccp->ucce);
-	out_be16(&uccp->ucce, events);
+	events = qe_ioread16be(&uccp->ucce);
+	qe_iowrite16be(events, &uccp->ucce);
 
 	if (events & UCC_UART_UCCE_BRKE)
 		uart_handle_break(&qe_port->port);
@@ -601,17 +602,17 @@ static void qe_uart_initbd(struct uart_qe_port *qe_port)
 	bdp = qe_port->rx_bd_base;
 	qe_port->rx_cur = qe_port->rx_bd_base;
 	for (i = 0; i < (qe_port->rx_nrfifos - 1); i++) {
-		out_be16(&bdp->status, BD_SC_EMPTY | BD_SC_INTRPT);
-		out_be32(&bdp->buf, cpu2qe_addr(bd_virt, qe_port));
-		out_be16(&bdp->length, 0);
+		qe_iowrite16be(BD_SC_EMPTY | BD_SC_INTRPT, &bdp->status);
+		qe_iowrite32be(cpu2qe_addr(bd_virt, qe_port), &bdp->buf);
+		qe_iowrite16be(0, &bdp->length);
 		bd_virt += qe_port->rx_fifosize;
 		bdp++;
 	}
 
 	/* */
-	out_be16(&bdp->status, BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT);
-	out_be32(&bdp->buf, cpu2qe_addr(bd_virt, qe_port));
-	out_be16(&bdp->length, 0);
+	qe_iowrite16be(BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT, &bdp->status);
+	qe_iowrite32be(cpu2qe_addr(bd_virt, qe_port), &bdp->buf);
+	qe_iowrite16be(0, &bdp->length);
 
 	/* Set the physical address of the host memory
 	 * buffers in the buffer descriptors, and the
@@ -622,21 +623,21 @@ static void qe_uart_initbd(struct uart_qe_port *qe_port)
 	qe_port->tx_cur = qe_port->tx_bd_base;
 	bdp = qe_port->tx_bd_base;
 	for (i = 0; i < (qe_port->tx_nrfifos - 1); i++) {
-		out_be16(&bdp->status, BD_SC_INTRPT);
-		out_be32(&bdp->buf, cpu2qe_addr(bd_virt, qe_port));
-		out_be16(&bdp->length, 0);
+		qe_iowrite16be(BD_SC_INTRPT, &bdp->status);
+		qe_iowrite32be(cpu2qe_addr(bd_virt, qe_port), &bdp->buf);
+		qe_iowrite16be(0, &bdp->length);
 		bd_virt += qe_port->tx_fifosize;
 		bdp++;
 	}
 
 	/* Loopback requires the preamble bit to be set on the first TX BD */
 #ifdef LOOPBACK
-	setbits16(&qe_port->tx_cur->status, BD_SC_P);
+	qe_setbits_be16(&qe_port->tx_cur->status, BD_SC_P);
 #endif
 
-	out_be16(&bdp->status, BD_SC_WRAP | BD_SC_INTRPT);
-	out_be32(&bdp->buf, cpu2qe_addr(bd_virt, qe_port));
-	out_be16(&bdp->length, 0);
+	qe_iowrite16be(BD_SC_WRAP | BD_SC_INTRPT, &bdp->status);
+	qe_iowrite32be(cpu2qe_addr(bd_virt, qe_port), &bdp->buf);
+	qe_iowrite16be(0, &bdp->length);
 }
 
 /*
@@ -658,78 +659,74 @@ static void qe_uart_init_ucc(struct uart_qe_port *qe_port)
 	ucc_slow_disable(qe_port->us_private, COMM_DIR_RX_AND_TX);
 
 	/* Program the UCC UART parameter RAM */
-	out_8(&uccup->common.rbmr, UCC_BMR_GBL | UCC_BMR_BO_BE);
-	out_8(&uccup->common.tbmr, UCC_BMR_GBL | UCC_BMR_BO_BE);
-	out_be16(&uccup->common.mrblr, qe_port->rx_fifosize);
-	out_be16(&uccup->maxidl, 0x10);
-	out_be16(&uccup->brkcr, 1);
-	out_be16(&uccup->parec, 0);
-	out_be16(&uccup->frmec, 0);
-	out_be16(&uccup->nosec, 0);
-	out_be16(&uccup->brkec, 0);
-	out_be16(&uccup->uaddr[0], 0);
-	out_be16(&uccup->uaddr[1], 0);
-	out_be16(&uccup->toseq, 0);
+	qe_iowrite8(UCC_BMR_GBL | UCC_BMR_BO_BE, &uccup->common.rbmr);
+	qe_iowrite8(UCC_BMR_GBL | UCC_BMR_BO_BE, &uccup->common.tbmr);
+	qe_iowrite16be(qe_port->rx_fifosize, &uccup->common.mrblr);
+	qe_iowrite16be(0x10, &uccup->maxidl);
+	qe_iowrite16be(1, &uccup->brkcr);
+	qe_iowrite16be(0, &uccup->parec);
+	qe_iowrite16be(0, &uccup->frmec);
+	qe_iowrite16be(0, &uccup->nosec);
+	qe_iowrite16be(0, &uccup->brkec);
+	qe_iowrite16be(0, &uccup->uaddr[0]);
+	qe_iowrite16be(0, &uccup->uaddr[1]);
+	qe_iowrite16be(0, &uccup->toseq);
 	for (i = 0; i < 8; i++)
-		out_be16(&uccup->cchars[i], 0xC000);
-	out_be16(&uccup->rccm, 0xc0ff);
+		qe_iowrite16be(0xC000, &uccup->cchars[i]);
+	qe_iowrite16be(0xc0ff, &uccup->rccm);
 
 	/* Configure the GUMR registers for UART */
 	if (soft_uart) {
 		/* Soft-UART requires a 1X multiplier for TX */
-		clrsetbits_be32(&uccp->gumr_l,
-			UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK |
-			UCC_SLOW_GUMR_L_RDCR_MASK,
-			UCC_SLOW_GUMR_L_MODE_UART | UCC_SLOW_GUMR_L_TDCR_1 |
-			UCC_SLOW_GUMR_L_RDCR_16);
-
-		clrsetbits_be32(&uccp->gumr_h, UCC_SLOW_GUMR_H_RFW,
-			UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX);
+		qe_clrsetbits_be32(&uccp->gumr_l,
+				   UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK | UCC_SLOW_GUMR_L_RDCR_MASK,
+				   UCC_SLOW_GUMR_L_MODE_UART | UCC_SLOW_GUMR_L_TDCR_1 | UCC_SLOW_GUMR_L_RDCR_16);
+
+		qe_clrsetbits_be32(&uccp->gumr_h, UCC_SLOW_GUMR_H_RFW,
+				   UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX);
 	} else {
-		clrsetbits_be32(&uccp->gumr_l,
-			UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK |
-			UCC_SLOW_GUMR_L_RDCR_MASK,
-			UCC_SLOW_GUMR_L_MODE_UART | UCC_SLOW_GUMR_L_TDCR_16 |
-			UCC_SLOW_GUMR_L_RDCR_16);
-
-		clrsetbits_be32(&uccp->gumr_h,
-			UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX,
-			UCC_SLOW_GUMR_H_RFW);
+		qe_clrsetbits_be32(&uccp->gumr_l,
+				   UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK | UCC_SLOW_GUMR_L_RDCR_MASK,
+				   UCC_SLOW_GUMR_L_MODE_UART | UCC_SLOW_GUMR_L_TDCR_16 | UCC_SLOW_GUMR_L_RDCR_16);
+
+		qe_clrsetbits_be32(&uccp->gumr_h,
+				   UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX,
+				   UCC_SLOW_GUMR_H_RFW);
 	}
 
 #ifdef LOOPBACK
-	clrsetbits_be32(&uccp->gumr_l, UCC_SLOW_GUMR_L_DIAG_MASK,
-		UCC_SLOW_GUMR_L_DIAG_LOOP);
-	clrsetbits_be32(&uccp->gumr_h,
-		UCC_SLOW_GUMR_H_CTSP | UCC_SLOW_GUMR_H_RSYN,
-		UCC_SLOW_GUMR_H_CDS);
+	qe_clrsetbits_be32(&uccp->gumr_l, UCC_SLOW_GUMR_L_DIAG_MASK,
+			   UCC_SLOW_GUMR_L_DIAG_LOOP);
+	qe_clrsetbits_be32(&uccp->gumr_h,
+			   UCC_SLOW_GUMR_H_CTSP | UCC_SLOW_GUMR_H_RSYN,
+			   UCC_SLOW_GUMR_H_CDS);
 #endif
 
 	/* Disable rx interrupts  and clear all pending events.  */
-	out_be16(&uccp->uccm, 0);
-	out_be16(&uccp->ucce, 0xffff);
-	out_be16(&uccp->udsr, 0x7e7e);
+	qe_iowrite16be(0, &uccp->uccm);
+	qe_iowrite16be(0xffff, &uccp->ucce);
+	qe_iowrite16be(0x7e7e, &uccp->udsr);
 
 	/* Initialize UPSMR */
-	out_be16(&uccp->upsmr, 0);
+	qe_iowrite16be(0, &uccp->upsmr);
 
 	if (soft_uart) {
-		out_be16(&uccup->supsmr, 0x30);
-		out_be16(&uccup->res92, 0);
-		out_be32(&uccup->rx_state, 0);
-		out_be32(&uccup->rx_cnt, 0);
-		out_8(&uccup->rx_bitmark, 0);
-		out_8(&uccup->rx_length, 10);
-		out_be32(&uccup->dump_ptr, 0x4000);
-		out_8(&uccup->rx_temp_dlst_qe, 0);
-		out_be32(&uccup->rx_frame_rem, 0);
-		out_8(&uccup->rx_frame_rem_size, 0);
+		qe_iowrite16be(0x30, &uccup->supsmr);
+		qe_iowrite16be(0, &uccup->res92);
+		qe_iowrite32be(0, &uccup->rx_state);
+		qe_iowrite32be(0, &uccup->rx_cnt);
+		qe_iowrite8(0, &uccup->rx_bitmark);
+		qe_iowrite8(10, &uccup->rx_length);
+		qe_iowrite32be(0x4000, &uccup->dump_ptr);
+		qe_iowrite8(0, &uccup->rx_temp_dlst_qe);
+		qe_iowrite32be(0, &uccup->rx_frame_rem);
+		qe_iowrite8(0, &uccup->rx_frame_rem_size);
 		/* Soft-UART requires TX to be 1X */
-		out_8(&uccup->tx_mode,
-			UCC_UART_TX_STATE_UART | UCC_UART_TX_STATE_X1);
-		out_be16(&uccup->tx_state, 0);
-		out_8(&uccup->resD4, 0);
-		out_be16(&uccup->resD5, 0);
+		qe_iowrite8(UCC_UART_TX_STATE_UART | UCC_UART_TX_STATE_X1,
+			    &uccup->tx_mode);
+		qe_iowrite16be(0, &uccup->tx_state);
+		qe_iowrite8(0, &uccup->resD4);
+		qe_iowrite16be(0, &uccup->resD5);
 
 		/* Set UART mode.
 		 * Enable receive and transmit.
@@ -743,22 +740,19 @@ static void qe_uart_init_ucc(struct uart_qe_port *qe_port)
 		 * ...
 		 * 6.Receiver must use 16x over sampling
 		 */
-		clrsetbits_be32(&uccp->gumr_l,
-			UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK |
-			UCC_SLOW_GUMR_L_RDCR_MASK,
-			UCC_SLOW_GUMR_L_MODE_QMC | UCC_SLOW_GUMR_L_TDCR_16 |
-			UCC_SLOW_GUMR_L_RDCR_16);
+		qe_clrsetbits_be32(&uccp->gumr_l,
+				   UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK | UCC_SLOW_GUMR_L_RDCR_MASK,
+				   UCC_SLOW_GUMR_L_MODE_QMC | UCC_SLOW_GUMR_L_TDCR_16 | UCC_SLOW_GUMR_L_RDCR_16);
 
-		clrsetbits_be32(&uccp->gumr_h,
-			UCC_SLOW_GUMR_H_RFW | UCC_SLOW_GUMR_H_RSYN,
-			UCC_SLOW_GUMR_H_SUART | UCC_SLOW_GUMR_H_TRX |
-			UCC_SLOW_GUMR_H_TTX | UCC_SLOW_GUMR_H_TFL);
+		qe_clrsetbits_be32(&uccp->gumr_h,
+				   UCC_SLOW_GUMR_H_RFW | UCC_SLOW_GUMR_H_RSYN,
+				   UCC_SLOW_GUMR_H_SUART | UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX | UCC_SLOW_GUMR_H_TFL);
 
 #ifdef LOOPBACK
-		clrsetbits_be32(&uccp->gumr_l, UCC_SLOW_GUMR_L_DIAG_MASK,
-				UCC_SLOW_GUMR_L_DIAG_LOOP);
-		clrbits32(&uccp->gumr_h, UCC_SLOW_GUMR_H_CTSP |
-			  UCC_SLOW_GUMR_H_CDS);
+		qe_clrsetbits_be32(&uccp->gumr_l, UCC_SLOW_GUMR_L_DIAG_MASK,
+				   UCC_SLOW_GUMR_L_DIAG_LOOP);
+		qe_clrbits_be32(&uccp->gumr_h,
+				UCC_SLOW_GUMR_H_CTSP | UCC_SLOW_GUMR_H_CDS);
 #endif
 
 		cecr_subblock = ucc_slow_get_qe_cr_subblock(qe_port->ucc_num);
@@ -801,7 +795,7 @@ static int qe_uart_startup(struct uart_port *port)
 	}
 
 	/* Startup rx-int */
-	setbits16(&qe_port->uccp->uccm, UCC_UART_UCCE_RX);
+	qe_setbits_be16(&qe_port->uccp->uccm, UCC_UART_UCCE_RX);
 	ucc_slow_enable(qe_port->us_private, COMM_DIR_RX_AND_TX);
 
 	return 0;
@@ -837,7 +831,7 @@ static void qe_uart_shutdown(struct uart_port *port)
 
 	/* Stop uarts */
 	ucc_slow_disable(qe_port->us_private, COMM_DIR_RX_AND_TX);
-	clrbits16(&uccp->uccm, UCC_UART_UCCE_TX | UCC_UART_UCCE_RX);
+	qe_clrbits_be16(&uccp->uccm, UCC_UART_UCCE_TX | UCC_UART_UCCE_RX);
 
 	/* Shut them really down and reinit buffer descriptors */
 	ucc_slow_graceful_stop_tx(qe_port->us_private);
@@ -857,9 +851,9 @@ static void qe_uart_set_termios(struct uart_port *port,
 	struct ucc_slow __iomem *uccp = qe_port->uccp;
 	unsigned int baud;
 	unsigned long flags;
-	u16 upsmr = in_be16(&uccp->upsmr);
+	u16 upsmr = qe_ioread16be(&uccp->upsmr);
 	struct ucc_uart_pram __iomem *uccup = qe_port->uccup;
-	u16 supsmr = in_be16(&uccup->supsmr);
+	u16 supsmr = qe_ioread16be(&uccup->supsmr);
 	u8 char_length = 2; /* 1 + CL + PEN + 1 + SL */
 
 	/* Character length programmed into the mode register is the
@@ -957,10 +951,10 @@ static void qe_uart_set_termios(struct uart_port *port,
 	/* Update the per-port timeout. */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	out_be16(&uccp->upsmr, upsmr);
+	qe_iowrite16be(upsmr, &uccp->upsmr);
 	if (soft_uart) {
-		out_be16(&uccup->supsmr, supsmr);
-		out_8(&uccup->rx_length, char_length);
+		qe_iowrite16be(supsmr, &uccup->supsmr);
+		qe_iowrite8(char_length, &uccup->rx_length);
 
 		/* Soft-UART requires a 1X multiplier for TX */
 		qe_setbrg(qe_port->us_info.rx_clock, baud, 16);
-- 
2.23.0

