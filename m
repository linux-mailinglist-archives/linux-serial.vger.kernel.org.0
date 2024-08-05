Return-Path: <linux-serial+bounces-5241-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E735F947961
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2024 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C43DB2210E
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E1155741;
	Mon,  5 Aug 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/nCnrmd"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B10155735;
	Mon,  5 Aug 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853255; cv=none; b=IVS56AuLoeZboETN/0y9Z1vfiq8jhcuLqBW9UzlDE0utjTari8Tc2Jilu4CTP115AHDVOC9Vuzfi9Cj85ysA+9dqIyqoMrH+fGtDAubRFHnrg96ORTRSAeCOlltf3ba8tAWE9Wl3EEv27ATYaiP7i9sf1dsdeW15Pz67uACU+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853255; c=relaxed/simple;
	bh=S6/Ai1CdLZDMBoYrAC6nEpen71bLbi3IKrnKG2Sv+Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9COlOvqT7SFc7DXWNGepz7mc9HB96Olf6C6/V/I6pMgyVeCokCaAhneG6o5iaZtD/BXpfuS8gfnXnTREVPX3C+qt3afNA5fnEwOahnsUROZ7EFZelKNoCe/1vy/RmuTrjCh9b1lyFHVfNv/wshpBw/kSLSlg8vjpYXPCJiWUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/nCnrmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55602C4AF18;
	Mon,  5 Aug 2024 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853255;
	bh=S6/Ai1CdLZDMBoYrAC6nEpen71bLbi3IKrnKG2Sv+Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/nCnrmdNe1qCiCgN25ZOodnz9CAb3fU01mLNXr9Lb9XmB+FEtMEhRCmpOm7v+rW0
	 OycdSitMYnmrOcGy3nmN3IL4Ze2pPxdRbbCcZudDgDy9UHYYMszha0A8snzXwxAB3R
	 tRRGduF6/XYkOy0zWgCtYvHHfsQlfEYLjFtC4ksybCeDxljU90QYDRm209ESvFcfqJ
	 LpkbPDwWFM7tDDbnq0dgl4VAvPyJMCoaCXQaCUbDN4LSeBfsBRwM8DQPY2Jf0hYyrp
	 ZBKeSXMsZhZhAhZSzwQ/qLB3dwXu8epS4pqc1U4mdTsyEbQ3Wlqpdc68TaQVcY1Q2y
	 EvmjbbTTDtkGQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 02/13] serial: protect uart_port_dtr_rts() in uart_shutdown() too
Date: Mon,  5 Aug 2024 12:20:35 +0200
Message-ID: <20240805102046.307511-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit af224ca2df29 (serial: core: Prevent unsafe uart port access, part
3) added few uport == NULL checks. It added one to uart_shutdown(), so
the commit assumes, uport can be NULL in there. But right after that
protection, there is an unprotected "uart_port_dtr_rts(uport, false);"
call. That is invoked only if HUPCL is set, so I assume that is the
reason why we do not see lots of these reports.

Or it cannot be NULL at this point at all for some reason :P.

Until the above is investigated, stay on the safe side and move this
dereference to the if too.

I got this inconsistency from Coverity under CID 1585130. Thanks.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 61c7e1268957..3afe77f05abf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -407,14 +407,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (uport && uart_console(uport) && tty) {
-			uport->cons->cflag = tty->termios.c_cflag;
-			uport->cons->ispeed = tty->termios.c_ispeed;
-			uport->cons->ospeed = tty->termios.c_ospeed;
-		}
+		if (uport) {
+			if (uart_console(uport) && tty) {
+				uport->cons->cflag = tty->termios.c_cflag;
+				uport->cons->ispeed = tty->termios.c_ispeed;
+				uport->cons->ospeed = tty->termios.c_ospeed;
+			}
 
-		if (!tty || C_HUPCL(tty))
-			uart_port_dtr_rts(uport, false);
+			if (!tty || C_HUPCL(tty))
+				uart_port_dtr_rts(uport, false);
+		}
 
 		uart_port_shutdown(port);
 	}
-- 
2.46.0


