Return-Path: <linux-serial+bounces-3786-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89AF8B0152
	for <lists+linux-serial@lfdr.de>; Wed, 24 Apr 2024 07:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7722849F7
	for <lists+linux-serial@lfdr.de>; Wed, 24 Apr 2024 05:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2815687C;
	Wed, 24 Apr 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=daniel.starke@siemens.com header.b="E78uxt4r"
X-Original-To: linux-serial@vger.kernel.org
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8048156876
	for <linux-serial@vger.kernel.org>; Wed, 24 Apr 2024 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937820; cv=none; b=g/PxIC/jYLdH3uM7jKO+a5Xcp4QSLNkfHOCcN16yC1UtmrWC9+6LiWdLcOWFHxEIp/jItp6jHQXJVlh40QFwyXTSQKKs7PFpmNTIZSQNg5xv2TO2tj5UuUn3td7XJDXVZpATtbtNXTxu0vtV4kw2NjALAeehz5HA/gAfA4/VrGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937820; c=relaxed/simple;
	bh=WgCUbfzNS3QF4DTL9ufCocSLSVuxeOwnd2Vq2/rJecE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIi9FeYj0KcT+hD9W1r9uGPDmJNNFzBwCCj76nqXOYYorEGHpi0H1ysNHzPkvNZULF/TmIrnTPI/J0f8+d1FFyxoZCWy4e20R1n4IOWeR7oXFgBnNTc2wJdl/ZtZMDJ5J/lMfs63MmFEAs8/HaPnYHLbl8bYjG2+EzEg0uNJwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=daniel.starke@siemens.com header.b=E78uxt4r; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240424055012b252d33da0fa0e4ffb
        for <linux-serial@vger.kernel.org>;
        Wed, 24 Apr 2024 07:50:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jJAfwSw6KITZv+CcSJwARJnFg2yhGSqyR70vWWtPD8k=;
 b=E78uxt4rxWd6hEOQoZDw9OUqvm+Z6VdUbxnclMmhO9vNdVnUzTfjPOP0WYiJ+EJhw8l+vW
 HF72aMNMt+pFxZXsExCgC1Y+fbHGxBQ207v053Xvwg9q9SLNlWom3y4B+Yk2ZaaNb8Oxcb7C
 bFQYm6CUCQJBmr1SLfqEkGt93WFhY=;
From: "D. Starke" <daniel.starke@siemens.com>
To: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	j51569436@gmail.com,
	Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 2/2] tty: n_gsm: fix missing receive state reset after mode switch
Date: Wed, 24 Apr 2024 07:48:42 +0200
Message-Id: <20240424054842.7741-2-daniel.starke@siemens.com>
In-Reply-To: <20240424054842.7741-1-daniel.starke@siemens.com>
References: <20240424054842.7741-1-daniel.starke@siemens.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer

From: Daniel Starke <daniel.starke@siemens.com>

The current implementation uses either gsm0_receive() or gsm1_receive()
depending on whether the user configured the mux in basic or advanced
option mode. Both functions share some state values over the same logical
elements of the frame. However, both frame types differ in their nature.
gsm0_receive() uses non-transparency framing, whereas gsm1_receive() uses
transparency mechanism. Switching between both modes leaves the receive
function in an undefined state when done during frame reception.

Fix this by splitting both states. Add gsm0_receive_state_check_and_fix()
and gsm1_receive_state_check_and_fix() to ensure that gsm->state is reset
after a change of gsm->receive.

Note that gsm->state is only accessed in:
- gsm0_receive()
- gsm1_receive()
- gsm_error()

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 133 ++++++++++++++++++++++++++++++--------------
 1 file changed, 92 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 7c697dab6f84..be35f7334ecd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -245,16 +245,18 @@ enum gsm_encoding {
 
 enum gsm_mux_state {
 	GSM_SEARCH,
-	GSM_START,
-	GSM_ADDRESS,
-	GSM_CONTROL,
-	GSM_LEN,
-	GSM_DATA,
-	GSM_FCS,
-	GSM_OVERRUN,
-	GSM_LEN0,
-	GSM_LEN1,
-	GSM_SSOF,
+	GSM0_ADDRESS,
+	GSM0_CONTROL,
+	GSM0_LEN0,
+	GSM0_LEN1,
+	GSM0_DATA,
+	GSM0_FCS,
+	GSM0_SSOF,
+	GSM1_START,
+	GSM1_ADDRESS,
+	GSM1_CONTROL,
+	GSM1_DATA,
+	GSM1_OVERRUN,
 };
 
 /*
@@ -2847,6 +2849,30 @@ static void gsm_queue(struct gsm_mux *gsm)
 	return;
 }
 
+/**
+ * gsm0_receive_state_check_and_fix	-	check and correct receive state
+ * @gsm: gsm data for this ldisc instance
+ *
+ * Ensures that the current receive state is valid for basic option mode.
+ */
+
+static void gsm0_receive_state_check_and_fix(struct gsm_mux *gsm)
+{
+	switch (gsm->state) {
+	case GSM_SEARCH:
+	case GSM0_ADDRESS:
+	case GSM0_CONTROL:
+	case GSM0_LEN0:
+	case GSM0_LEN1:
+	case GSM0_DATA:
+	case GSM0_FCS:
+	case GSM0_SSOF:
+		break;
+	default:
+		gsm->state = GSM_SEARCH;
+		break;
+	}
+}
 
 /**
  *	gsm0_receive	-	perform processing for non-transparency
@@ -2860,26 +2886,27 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 {
 	unsigned int len;
 
+	gsm0_receive_state_check_and_fix(gsm);
 	switch (gsm->state) {
 	case GSM_SEARCH:	/* SOF marker */
 		if (c == GSM0_SOF) {
-			gsm->state = GSM_ADDRESS;
+			gsm->state = GSM0_ADDRESS;
 			gsm->address = 0;
 			gsm->len = 0;
 			gsm->fcs = INIT_FCS;
 		}
 		break;
-	case GSM_ADDRESS:	/* Address EA */
+	case GSM0_ADDRESS:	/* Address EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-			gsm->state = GSM_CONTROL;
+			gsm->state = GSM0_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM0_CONTROL:	/* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
-		gsm->state = GSM_LEN0;
+		gsm->state = GSM0_LEN0;
 		break;
-	case GSM_LEN0:		/* Length EA */
+	case GSM0_LEN0:		/* Length EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->len, c)) {
 			if (gsm->len > gsm->mru) {
@@ -2889,14 +2916,14 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 			}
 			gsm->count = 0;
 			if (!gsm->len)
-				gsm->state = GSM_FCS;
+				gsm->state = GSM0_FCS;
 			else
-				gsm->state = GSM_DATA;
+				gsm->state = GSM0_DATA;
 			break;
 		}
-		gsm->state = GSM_LEN1;
+		gsm->state = GSM0_LEN1;
 		break;
-	case GSM_LEN1:
+	case GSM0_LEN1:
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		len = c;
 		gsm->len |= len << 7;
@@ -2907,11 +2934,11 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 		}
 		gsm->count = 0;
 		if (!gsm->len)
-			gsm->state = GSM_FCS;
+			gsm->state = GSM0_FCS;
 		else
-			gsm->state = GSM_DATA;
+			gsm->state = GSM0_DATA;
 		break;
-	case GSM_DATA:		/* Data */
+	case GSM0_DATA:		/* Data */
 		gsm->buf[gsm->count++] = c;
 		if (gsm->count >= MAX_MRU) {
 			gsm->bad_size++;
@@ -2922,14 +2949,14 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
 							     gsm->count);
 			}
-			gsm->state = GSM_FCS;
+			gsm->state = GSM0_FCS;
 		}
 		break;
-	case GSM_FCS:		/* FCS follows the packet */
+	case GSM0_FCS:		/* FCS follows the packet */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
-		gsm->state = GSM_SSOF;
+		gsm->state = GSM0_SSOF;
 		break;
-	case GSM_SSOF:
+	case GSM0_SSOF:
 		gsm->state = GSM_SEARCH;
 		if (c == GSM0_SOF)
 			gsm_queue(gsm);
@@ -2942,6 +2969,29 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 	}
 }
 
+/**
+ * gsm1_receive_state_check_and_fix	-	check and correct receive state
+ * @gsm: gsm data for this ldisc instance
+ *
+ * Ensures that the current receive state is valid for advanced option mode.
+ */
+
+static void gsm1_receive_state_check_and_fix(struct gsm_mux *gsm)
+{
+	switch (gsm->state) {
+	case GSM_SEARCH:
+	case GSM1_START:
+	case GSM1_ADDRESS:
+	case GSM1_CONTROL:
+	case GSM1_DATA:
+	case GSM1_OVERRUN:
+		break;
+	default:
+		gsm->state = GSM_SEARCH;
+		break;
+	}
+}
+
 /**
  *	gsm1_receive	-	perform processing for non-transparency
  *	@gsm: gsm data for this ldisc instance
@@ -2952,6 +3002,7 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 
 static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 {
+	gsm1_receive_state_check_and_fix(gsm);
 	/* handle XON/XOFF */
 	if ((c & ISO_IEC_646_MASK) == XON) {
 		gsm->constipated = true;
@@ -2964,11 +3015,11 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 	}
 	if (c == GSM1_SOF) {
 		/* EOF is only valid in frame if we have got to the data state */
-		if (gsm->state == GSM_DATA) {
+		if (gsm->state == GSM1_DATA) {
 			if (gsm->count < 1) {
 				/* Missing FSC */
 				gsm->malformed++;
-				gsm->state = GSM_START;
+				gsm->state = GSM1_START;
 				return;
 			}
 			/* Remove the FCS from data */
@@ -2984,14 +3035,14 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 			gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->buf[gsm->count]);
 			gsm->len = gsm->count;
 			gsm_queue(gsm);
-			gsm->state  = GSM_START;
+			gsm->state  = GSM1_START;
 			return;
 		}
 		/* Any partial frame was a runt so go back to start */
-		if (gsm->state != GSM_START) {
+		if (gsm->state != GSM1_START) {
 			if (gsm->state != GSM_SEARCH)
 				gsm->malformed++;
-			gsm->state = GSM_START;
+			gsm->state = GSM1_START;
 		}
 		/* A SOF in GSM_START means we are still reading idling or
 		   framing bytes */
@@ -3012,30 +3063,30 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 		gsm->escape = false;
 	}
 	switch (gsm->state) {
-	case GSM_START:		/* First byte after SOF */
+	case GSM1_START:		/* First byte after SOF */
 		gsm->address = 0;
-		gsm->state = GSM_ADDRESS;
+		gsm->state = GSM1_ADDRESS;
 		gsm->fcs = INIT_FCS;
 		fallthrough;
-	case GSM_ADDRESS:	/* Address continuation */
+	case GSM1_ADDRESS:	/* Address continuation */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-			gsm->state = GSM_CONTROL;
+			gsm->state = GSM1_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM1_CONTROL:	/* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
 		gsm->count = 0;
-		gsm->state = GSM_DATA;
+		gsm->state = GSM1_DATA;
 		break;
-	case GSM_DATA:		/* Data */
+	case GSM1_DATA:		/* Data */
 		if (gsm->count > gsm->mru || gsm->count > MAX_MRU) {	/* Allow one for the FCS */
-			gsm->state = GSM_OVERRUN;
+			gsm->state = GSM1_OVERRUN;
 			gsm->bad_size++;
 		} else
 			gsm->buf[gsm->count++] = c;
 		break;
-	case GSM_OVERRUN:	/* Over-long - eg a dropped SOF */
+	case GSM1_OVERRUN:	/* Over-long - eg a dropped SOF */
 		break;
 	default:
 		pr_debug("%s: unhandled state: %d\n", __func__, gsm->state);
-- 
2.34.1


