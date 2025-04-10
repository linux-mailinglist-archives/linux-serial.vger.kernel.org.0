Return-Path: <linux-serial+bounces-8853-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AACA8359C
	for <lists+linux-serial@lfdr.de>; Thu, 10 Apr 2025 03:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C621D1B63427
	for <lists+linux-serial@lfdr.de>; Thu, 10 Apr 2025 01:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC61B6CF1;
	Thu, 10 Apr 2025 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="PEY06lps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYJLdwWS"
X-Original-To: linux-serial@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447111684B4;
	Thu, 10 Apr 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247947; cv=none; b=kwWFmh+k34xYrnZ7xeR119KDo4vddmfzQEZEKyeoR6pCTpyh1zE4sklY0vCw3v1L77A3s+WXlLX+GtfrcIvXYhPvgjSeKusHqC0qIe6nIMM2c8D1NYI08GUzLOpbSXbo+dLJ+dI/Mps5Lop5DZtw4KrqEuhduiPjDTVa0ZbRxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247947; c=relaxed/simple;
	bh=J1U+t4G6lHglnug+NI68RmpaEIHqeRXzg8opSv1VJqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUU7aSd/vSYPDgwco7Y8NE5s7tc0nXH0KeSGAv6NwGbL+nmbukh3aGqNcncsc/GDK6YVXxJQCI+ayp75k6maCshcSHshH3sr2zH61bfQgkbmEGpn/G51jOZ69VM6ypA+Jt7nvHuskM7raDBCeJVNjsRpvZSluCk1tvbvhLR5AMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=PEY06lps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SYJLdwWS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 544D913801E9;
	Wed,  9 Apr 2025 21:19:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 09 Apr 2025 21:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247943; x=
	1744334343; bh=s6rkQbGtA5qhvaLT3wXBVihHm47BLmvyKvXc8KriMHI=; b=P
	EY06lpsLd5MKODHyHFPr6p96Tt1f1wHCv5B2UzM/2wG1VjDf4HzoprN7y42ror0/
	n/8D2wsLAV64dGOl8DgSMGWyczvGhC5xqhP4i/tUlBd4strEG26MibGyO4t9uHVR
	wMYB26fbGi4Ii3MbI0GS4h4UnIvnHCevB2Z0kpRD8PtWXSCoSQBW0/cVJYgM8vrK
	OSZPj4v/2DJy0gkbF+vy7kn01QC4RCp0k+MiLwCGLlf7UT73SMxpgGp5uzujeBFC
	QrxGIZzC0ZGNooBOReIZVqUWgv1tZdAzTGMRTjO+p01/drE1Ax9qSOSmdLmr1zsj
	MDnbku0rKL1EbeTDkEM0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247943; x=1744334343; bh=s
	6rkQbGtA5qhvaLT3wXBVihHm47BLmvyKvXc8KriMHI=; b=SYJLdwWSKHSKKFE3v
	DkvuGVmpCREcAhUq8U+jbs0Gww9pYS+9IpBWzaWQ/XDJClyIF8aT1XXkLiQrIXfz
	+c42kHjqXE0w7ZzrUmQifjko8Gxxt/2gHb49D5O9H6PsV8HQYWwtLrmpAAhcOMHB
	8o98fzp5OPz2E/Y6HucPd2ke+L1Ee0e6JnnRMOt3n4qObkKlFGNm8YbKf2YNejEZ
	W9lpWy3v9W3iJkLddMMQzSCgD74ZKaLxQuqE/6JIxTEBxwc6Elh/jHcVaF3NIS1t
	1SdQ5lD598NAdLoCrcd5rmDVDO3GwoDXHfTVQvSm9324thNLQuOL4UrSgZRKDRig
	piIpg==
X-ME-Sender: <xms:hxz3Z1P7gqlZ2ZeCCAwz7LsC2ek-KnNkSgMXSV70EJHHlPmV3SKxBA>
    <xme:hxz3Z3-wC800pFxGksQvX-94enxXq_HPCYFCyylsF_A2VGSDSD4FZ6TEfSsZ-P7Vi
    4gjaqdydGzpEJEVv0Q>
X-ME-Received: <xmr:hxz3Z0SYAJ3znP8Umxsa5nBTj1OKbe9m6Rt0WHKimRTujBVPehzNqnaNsvh_MgvjxcONLCqwMc8KKECtd-vaKC3EpeTQ6K1pNgXn7F8oZCjhcQ4F1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnhepleektdffjeevfefhiedtudevudetjeejvdej
    uedtvdevveefuedujeejffetieeknecuffhomhgrihhnpegtrghmrdgrtgdruhhknecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehf
    lhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohep
    jhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhgvsehmihgv
    lhhkvgdrtggtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hxz3ZxtZof0gkiryrCNhrl9elb7BdXJGWALZLM7u8SG9icSf52v0_g>
    <xmx:hxz3Z9f26L65vLwjQj3gAjqtyyh6ctxT3Hv9ApZeXiHvjeVTBCes3Q>
    <xmx:hxz3Z93fEBjAdkFq0nhSmoD4K1nY3PkWgxDmG4s6tz_-kXRwtlYrNA>
    <xmx:hxz3Z59wqeAYP_orEO46rsEnrJPxDo8uX9pi7YSTC-sAa_yFwYMcaA>
    <xmx:hxz3Z1_im96UFnm89pLnQ_OEM8N9ieyTXYaOFPCbAGNCEeTrAYXLT6fn>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:03 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E9CB810D8B74;
	Wed,  9 Apr 2025 21:19:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] vt: update ucs_width.c using gen_ucs_width.py
Date: Wed,  9 Apr 2025 21:13:57 -0400
Message-ID: <20250410011839.64418-6-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410011839.64418-1-nico@fluxnic.net>
References: <20250410011839.64418-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

This replaces ucs_width.c with the code generated by gen_ucs_width.py
providing comprehensive tables for double-width and zero-width Unicode
code points. Also make ucs_is_zero_width() effective.

Note: scripts/checkpatch.pl complains about "... exceeds 100 columns".
      Please ignore.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/ucs_width.c | 495 +++++++++++++++++++++++++++++++++++--
 include/linux/consolemap.h |   6 +-
 2 files changed, 475 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/vt/ucs_width.c b/drivers/tty/vt/ucs_width.c
index 5f0bde30a1..47b22583bd 100644
--- a/drivers/tty/vt/ucs_width.c
+++ b/drivers/tty/vt/ucs_width.c
@@ -1,45 +1,498 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * ucs_width.c - Unicode character width lookup
+ *
+ * Auto-generated by gen_ucs_width.py
+ *
+ * Unicode Version: 16.0.0
+ */
 
 #include <linux/types.h>
 #include <linux/array_size.h>
 #include <linux/bsearch.h>
 #include <linux/consolemap.h>
 
-/* ucs_is_double_width() is based on the wcwidth() implementation by
- * Markus Kuhn -- 2007-05-26 (Unicode 5.0)
- * Latest version: https://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c
- */
-
 struct interval {
 	uint32_t first;
 	uint32_t last;
 };
 
-static int ucs_cmp(const void *key, const void *elt)
+/* Zero-width character ranges */
+static const struct interval zero_width_ranges[] = {
+	{ 0x000AD, 0x000AD }, /* SOFT HYPHEN */
+	{ 0x00300, 0x0036F }, /* COMBINING GRAVE ACCENT - COMBINING LATIN SMALL LETTER X */
+	{ 0x00483, 0x00489 }, /* COMBINING CYRILLIC TITLO - COMBINING CYRILLIC MILLIONS SIGN */
+	{ 0x00591, 0x005BD }, /* HEBREW ACCENT ETNAHTA - HEBREW POINT METEG */
+	{ 0x005BF, 0x005BF }, /* HEBREW POINT RAFE */
+	{ 0x005C1, 0x005C2 }, /* HEBREW POINT SHIN DOT - HEBREW POINT SIN DOT */
+	{ 0x005C4, 0x005C5 }, /* HEBREW MARK UPPER DOT - HEBREW MARK LOWER DOT */
+	{ 0x005C7, 0x005C7 }, /* HEBREW POINT QAMATS QATAN */
+	{ 0x00600, 0x00605 }, /* ARABIC NUMBER SIGN - ARABIC NUMBER MARK ABOVE */
+	{ 0x00610, 0x0061A }, /* ARABIC SIGN SALLALLAHOU ALAYHE WASSALLAM - ARABIC SMALL KASRA */
+	{ 0x0064B, 0x0065F }, /* ARABIC FATHATAN - ARABIC WAVY HAMZA BELOW */
+	{ 0x00670, 0x00670 }, /* ARABIC LETTER SUPERSCRIPT ALEF */
+	{ 0x006D6, 0x006DC }, /* ARABIC SMALL HIGH LIGATURE SAD WITH LAM WITH ALEF MAKSURA - ARABIC SMALL HIGH SEEN */
+	{ 0x006DF, 0x006E4 }, /* ARABIC SMALL HIGH ROUNDED ZERO - ARABIC SMALL HIGH MADDA */
+	{ 0x006E7, 0x006E8 }, /* ARABIC SMALL HIGH YEH - ARABIC SMALL HIGH NOON */
+	{ 0x006EA, 0x006ED }, /* ARABIC EMPTY CENTRE LOW STOP - ARABIC SMALL LOW MEEM */
+	{ 0x00711, 0x00711 }, /* SYRIAC LETTER SUPERSCRIPT ALAPH */
+	{ 0x00730, 0x0074A }, /* SYRIAC PTHAHA ABOVE - SYRIAC BARREKH */
+	{ 0x007A6, 0x007B0 }, /* THAANA ABAFILI - THAANA SUKUN */
+	{ 0x007EB, 0x007F3 }, /* NKO COMBINING SHORT HIGH TONE - NKO COMBINING DOUBLE DOT ABOVE */
+	{ 0x007FD, 0x007FD }, /* NKO DANTAYALAN */
+	{ 0x00816, 0x00819 }, /* SAMARITAN MARK IN - SAMARITAN MARK DAGESH */
+	{ 0x0081B, 0x00823 }, /* SAMARITAN MARK EPENTHETIC YUT - SAMARITAN VOWEL SIGN A */
+	{ 0x00825, 0x00827 }, /* SAMARITAN VOWEL SIGN SHORT A - SAMARITAN VOWEL SIGN U */
+	{ 0x00829, 0x0082D }, /* SAMARITAN VOWEL SIGN LONG I - SAMARITAN MARK NEQUDAA */
+	{ 0x00859, 0x0085B }, /* MANDAIC AFFRICATION MARK - MANDAIC GEMINATION MARK */
+	{ 0x00890, 0x00891 }, /* ARABIC POUND MARK ABOVE - ARABIC PIASTRE MARK ABOVE */
+	{ 0x00897, 0x0089F }, /* ARABIC PEPET - ARABIC HALF MADDA OVER MADDA */
+	{ 0x008CA, 0x00903 }, /* ARABIC SMALL HIGH FARSI YEH - DEVANAGARI SIGN VISARGA */
+	{ 0x0093A, 0x0093C }, /* DEVANAGARI VOWEL SIGN OE - DEVANAGARI SIGN NUKTA */
+	{ 0x0093E, 0x0094F }, /* DEVANAGARI VOWEL SIGN AA - DEVANAGARI VOWEL SIGN AW */
+	{ 0x00951, 0x00957 }, /* DEVANAGARI STRESS SIGN UDATTA - DEVANAGARI VOWEL SIGN UUE */
+	{ 0x00962, 0x00963 }, /* DEVANAGARI VOWEL SIGN VOCALIC L - DEVANAGARI VOWEL SIGN VOCALIC LL */
+	{ 0x00981, 0x00983 }, /* BENGALI SIGN CANDRABINDU - BENGALI SIGN VISARGA */
+	{ 0x009BC, 0x009BC }, /* BENGALI SIGN NUKTA */
+	{ 0x009BE, 0x009C4 }, /* BENGALI VOWEL SIGN AA - BENGALI VOWEL SIGN VOCALIC RR */
+	{ 0x009C7, 0x009C8 }, /* BENGALI VOWEL SIGN E - BENGALI VOWEL SIGN AI */
+	{ 0x009CB, 0x009CD }, /* BENGALI VOWEL SIGN O - BENGALI SIGN VIRAMA */
+	{ 0x009D7, 0x009D7 }, /* BENGALI AU LENGTH MARK */
+	{ 0x009E2, 0x009E3 }, /* BENGALI VOWEL SIGN VOCALIC L - BENGALI VOWEL SIGN VOCALIC LL */
+	{ 0x009FE, 0x009FE }, /* BENGALI SANDHI MARK */
+	{ 0x00A01, 0x00A03 }, /* GURMUKHI SIGN ADAK BINDI - GURMUKHI SIGN VISARGA */
+	{ 0x00A3C, 0x00A3C }, /* GURMUKHI SIGN NUKTA */
+	{ 0x00A3E, 0x00A42 }, /* GURMUKHI VOWEL SIGN AA - GURMUKHI VOWEL SIGN UU */
+	{ 0x00A47, 0x00A48 }, /* GURMUKHI VOWEL SIGN EE - GURMUKHI VOWEL SIGN AI */
+	{ 0x00A4B, 0x00A4D }, /* GURMUKHI VOWEL SIGN OO - GURMUKHI SIGN VIRAMA */
+	{ 0x00A51, 0x00A51 }, /* GURMUKHI SIGN UDAAT */
+	{ 0x00A70, 0x00A71 }, /* GURMUKHI TIPPI - GURMUKHI ADDAK */
+	{ 0x00A75, 0x00A75 }, /* GURMUKHI SIGN YAKASH */
+	{ 0x00A81, 0x00A83 }, /* GUJARATI SIGN CANDRABINDU - GUJARATI SIGN VISARGA */
+	{ 0x00ABC, 0x00ABC }, /* GUJARATI SIGN NUKTA */
+	{ 0x00ABE, 0x00AC5 }, /* GUJARATI VOWEL SIGN AA - GUJARATI VOWEL SIGN CANDRA E */
+	{ 0x00AC7, 0x00AC9 }, /* GUJARATI VOWEL SIGN E - GUJARATI VOWEL SIGN CANDRA O */
+	{ 0x00ACB, 0x00ACD }, /* GUJARATI VOWEL SIGN O - GUJARATI SIGN VIRAMA */
+	{ 0x00AE2, 0x00AE3 }, /* GUJARATI VOWEL SIGN VOCALIC L - GUJARATI VOWEL SIGN VOCALIC LL */
+	{ 0x00AFA, 0x00AFF }, /* GUJARATI SIGN SUKUN - GUJARATI SIGN TWO-CIRCLE NUKTA ABOVE */
+	{ 0x00B01, 0x00B03 }, /* ORIYA SIGN CANDRABINDU - ORIYA SIGN VISARGA */
+	{ 0x00B3C, 0x00B3C }, /* ORIYA SIGN NUKTA */
+	{ 0x00B3E, 0x00B44 }, /* ORIYA VOWEL SIGN AA - ORIYA VOWEL SIGN VOCALIC RR */
+	{ 0x00B47, 0x00B48 }, /* ORIYA VOWEL SIGN E - ORIYA VOWEL SIGN AI */
+	{ 0x00B4B, 0x00B4D }, /* ORIYA VOWEL SIGN O - ORIYA SIGN VIRAMA */
+	{ 0x00B55, 0x00B57 }, /* ORIYA SIGN OVERLINE - ORIYA AU LENGTH MARK */
+	{ 0x00B62, 0x00B63 }, /* ORIYA VOWEL SIGN VOCALIC L - ORIYA VOWEL SIGN VOCALIC LL */
+	{ 0x00B82, 0x00B82 }, /* TAMIL SIGN ANUSVARA */
+	{ 0x00BBE, 0x00BC2 }, /* TAMIL VOWEL SIGN AA - TAMIL VOWEL SIGN UU */
+	{ 0x00BC6, 0x00BC8 }, /* TAMIL VOWEL SIGN E - TAMIL VOWEL SIGN AI */
+	{ 0x00BCA, 0x00BCD }, /* TAMIL VOWEL SIGN O - TAMIL SIGN VIRAMA */
+	{ 0x00BD7, 0x00BD7 }, /* TAMIL AU LENGTH MARK */
+	{ 0x00C00, 0x00C04 }, /* TELUGU SIGN COMBINING CANDRABINDU ABOVE - TELUGU SIGN COMBINING ANUSVARA ABOVE */
+	{ 0x00C3C, 0x00C3C }, /* TELUGU SIGN NUKTA */
+	{ 0x00C3E, 0x00C44 }, /* TELUGU VOWEL SIGN AA - TELUGU VOWEL SIGN VOCALIC RR */
+	{ 0x00C46, 0x00C48 }, /* TELUGU VOWEL SIGN E - TELUGU VOWEL SIGN AI */
+	{ 0x00C4A, 0x00C4D }, /* TELUGU VOWEL SIGN O - TELUGU SIGN VIRAMA */
+	{ 0x00C55, 0x00C56 }, /* TELUGU LENGTH MARK - TELUGU AI LENGTH MARK */
+	{ 0x00C62, 0x00C63 }, /* TELUGU VOWEL SIGN VOCALIC L - TELUGU VOWEL SIGN VOCALIC LL */
+	{ 0x00C81, 0x00C83 }, /* KANNADA SIGN CANDRABINDU - KANNADA SIGN VISARGA */
+	{ 0x00CBC, 0x00CBC }, /* KANNADA SIGN NUKTA */
+	{ 0x00CBE, 0x00CC4 }, /* KANNADA VOWEL SIGN AA - KANNADA VOWEL SIGN VOCALIC RR */
+	{ 0x00CC6, 0x00CC8 }, /* KANNADA VOWEL SIGN E - KANNADA VOWEL SIGN AI */
+	{ 0x00CCA, 0x00CCD }, /* KANNADA VOWEL SIGN O - KANNADA SIGN VIRAMA */
+	{ 0x00CD5, 0x00CD6 }, /* KANNADA LENGTH MARK - KANNADA AI LENGTH MARK */
+	{ 0x00CE2, 0x00CE3 }, /* KANNADA VOWEL SIGN VOCALIC L - KANNADA VOWEL SIGN VOCALIC LL */
+	{ 0x00CF3, 0x00CF3 }, /* KANNADA SIGN COMBINING ANUSVARA ABOVE RIGHT */
+	{ 0x00D00, 0x00D03 }, /* MALAYALAM SIGN COMBINING ANUSVARA ABOVE - MALAYALAM SIGN VISARGA */
+	{ 0x00D3B, 0x00D3C }, /* MALAYALAM SIGN VERTICAL BAR VIRAMA - MALAYALAM SIGN CIRCULAR VIRAMA */
+	{ 0x00D3E, 0x00D44 }, /* MALAYALAM VOWEL SIGN AA - MALAYALAM VOWEL SIGN VOCALIC RR */
+	{ 0x00D46, 0x00D48 }, /* MALAYALAM VOWEL SIGN E - MALAYALAM VOWEL SIGN AI */
+	{ 0x00D4A, 0x00D4D }, /* MALAYALAM VOWEL SIGN O - MALAYALAM SIGN VIRAMA */
+	{ 0x00D57, 0x00D57 }, /* MALAYALAM AU LENGTH MARK */
+	{ 0x00D62, 0x00D63 }, /* MALAYALAM VOWEL SIGN VOCALIC L - MALAYALAM VOWEL SIGN VOCALIC LL */
+	{ 0x00D81, 0x00D83 }, /* SINHALA SIGN CANDRABINDU - SINHALA SIGN VISARGAYA */
+	{ 0x00DCA, 0x00DCA }, /* SINHALA SIGN AL-LAKUNA */
+	{ 0x00DCF, 0x00DD4 }, /* SINHALA VOWEL SIGN AELA-PILLA - SINHALA VOWEL SIGN KETTI PAA-PILLA */
+	{ 0x00DD6, 0x00DD6 }, /* SINHALA VOWEL SIGN DIGA PAA-PILLA */
+	{ 0x00DD8, 0x00DDF }, /* SINHALA VOWEL SIGN GAETTA-PILLA - SINHALA VOWEL SIGN GAYANUKITTA */
+	{ 0x00DF2, 0x00DF3 }, /* SINHALA VOWEL SIGN DIGA GAETTA-PILLA - SINHALA VOWEL SIGN DIGA GAYANUKITTA */
+	{ 0x00E31, 0x00E31 }, /* THAI CHARACTER MAI HAN-AKAT */
+	{ 0x00E34, 0x00E3A }, /* THAI CHARACTER SARA I - THAI CHARACTER PHINTHU */
+	{ 0x00E47, 0x00E4E }, /* THAI CHARACTER MAITAIKHU - THAI CHARACTER YAMAKKAN */
+	{ 0x00EB1, 0x00EB1 }, /* LAO VOWEL SIGN MAI KAN */
+	{ 0x00EB4, 0x00EBC }, /* LAO VOWEL SIGN I - LAO SEMIVOWEL SIGN LO */
+	{ 0x00EC8, 0x00ECE }, /* LAO TONE MAI EK - LAO YAMAKKAN */
+	{ 0x00F18, 0x00F19 }, /* TIBETAN ASTROLOGICAL SIGN -KHYUD PA - TIBETAN ASTROLOGICAL SIGN SDONG TSHUGS */
+	{ 0x00F35, 0x00F35 }, /* TIBETAN MARK NGAS BZUNG NYI ZLA */
+	{ 0x00F37, 0x00F37 }, /* TIBETAN MARK NGAS BZUNG SGOR RTAGS */
+	{ 0x00F39, 0x00F39 }, /* TIBETAN MARK TSA -PHRU */
+	{ 0x00F3E, 0x00F3F }, /* TIBETAN SIGN YAR TSHES - TIBETAN SIGN MAR TSHES */
+	{ 0x00F71, 0x00F84 }, /* TIBETAN VOWEL SIGN AA - TIBETAN MARK HALANTA */
+	{ 0x00F86, 0x00F87 }, /* TIBETAN SIGN LCI RTAGS - TIBETAN SIGN YANG RTAGS */
+	{ 0x00F8D, 0x00F97 }, /* TIBETAN SUBJOINED SIGN LCE TSA CAN - TIBETAN SUBJOINED LETTER JA */
+	{ 0x00F99, 0x00FBC }, /* TIBETAN SUBJOINED LETTER NYA - TIBETAN SUBJOINED LETTER FIXED-FORM RA */
+	{ 0x00FC6, 0x00FC6 }, /* TIBETAN SYMBOL PADMA GDAN */
+	{ 0x0102B, 0x0103E }, /* MYANMAR VOWEL SIGN TALL AA - MYANMAR CONSONANT SIGN MEDIAL HA */
+	{ 0x01056, 0x01059 }, /* MYANMAR VOWEL SIGN VOCALIC R - MYANMAR VOWEL SIGN VOCALIC LL */
+	{ 0x0105E, 0x01060 }, /* MYANMAR CONSONANT SIGN MON MEDIAL NA - MYANMAR CONSONANT SIGN MON MEDIAL LA */
+	{ 0x01062, 0x01064 }, /* MYANMAR VOWEL SIGN SGAW KAREN EU - MYANMAR TONE MARK SGAW KAREN KE PHO */
+	{ 0x01067, 0x0106D }, /* MYANMAR VOWEL SIGN WESTERN PWO KAREN EU - MYANMAR SIGN WESTERN PWO KAREN TONE-5 */
+	{ 0x01071, 0x01074 }, /* MYANMAR VOWEL SIGN GEBA KAREN I - MYANMAR VOWEL SIGN KAYAH EE */
+	{ 0x01082, 0x0108D }, /* MYANMAR CONSONANT SIGN SHAN MEDIAL WA - MYANMAR SIGN SHAN COUNCIL EMPHATIC TONE */
+	{ 0x0108F, 0x0108F }, /* MYANMAR SIGN RUMAI PALAUNG TONE-5 */
+	{ 0x0109A, 0x0109D }, /* MYANMAR SIGN KHAMTI TONE-1 - MYANMAR VOWEL SIGN AITON AI */
+	{ 0x0135D, 0x0135F }, /* ETHIOPIC COMBINING GEMINATION AND VOWEL LENGTH MARK - ETHIOPIC COMBINING GEMINATION MARK */
+	{ 0x01712, 0x01715 }, /* TAGALOG VOWEL SIGN I - TAGALOG SIGN PAMUDPOD */
+	{ 0x01732, 0x01734 }, /* HANUNOO VOWEL SIGN I - HANUNOO SIGN PAMUDPOD */
+	{ 0x01752, 0x01753 }, /* BUHID VOWEL SIGN I - BUHID VOWEL SIGN U */
+	{ 0x01772, 0x01773 }, /* TAGBANWA VOWEL SIGN I - TAGBANWA VOWEL SIGN U */
+	{ 0x017B4, 0x017D3 }, /* KHMER VOWEL INHERENT AQ - KHMER SIGN BATHAMASAT */
+	{ 0x017DD, 0x017DD }, /* KHMER SIGN ATTHACAN */
+	{ 0x0180B, 0x0180D }, /* MONGOLIAN FREE VARIATION SELECTOR ONE - MONGOLIAN FREE VARIATION SELECTOR THREE */
+	{ 0x0180F, 0x0180F }, /* MONGOLIAN FREE VARIATION SELECTOR FOUR */
+	{ 0x01885, 0x01886 }, /* MONGOLIAN LETTER ALI GALI BALUDA - MONGOLIAN LETTER ALI GALI THREE BALUDA */
+	{ 0x018A9, 0x018A9 }, /* MONGOLIAN LETTER ALI GALI DAGALGA */
+	{ 0x01920, 0x0192B }, /* LIMBU VOWEL SIGN A - LIMBU SUBJOINED LETTER WA */
+	{ 0x01930, 0x0193B }, /* LIMBU SMALL LETTER KA - LIMBU SIGN SA-I */
+	{ 0x01A17, 0x01A1B }, /* BUGINESE VOWEL SIGN I - BUGINESE VOWEL SIGN AE */
+	{ 0x01A55, 0x01A5E }, /* TAI THAM CONSONANT SIGN MEDIAL RA - TAI THAM CONSONANT SIGN SA */
+	{ 0x01A60, 0x01A7C }, /* TAI THAM SIGN SAKOT - TAI THAM SIGN KHUEN-LUE KARAN */
+	{ 0x01A7F, 0x01A7F }, /* TAI THAM COMBINING CRYPTOGRAMMIC DOT */
+	{ 0x01AB0, 0x01ACE }, /* COMBINING DOUBLED CIRCUMFLEX ACCENT - COMBINING LATIN SMALL LETTER INSULAR T */
+	{ 0x01B00, 0x01B04 }, /* BALINESE SIGN ULU RICEM - BALINESE SIGN BISAH */
+	{ 0x01B34, 0x01B44 }, /* BALINESE SIGN REREKAN - BALINESE ADEG ADEG */
+	{ 0x01B6B, 0x01B73 }, /* BALINESE MUSICAL SYMBOL COMBINING TEGEH - BALINESE MUSICAL SYMBOL COMBINING GONG */
+	{ 0x01B80, 0x01B82 }, /* SUNDANESE SIGN PANYECEK - SUNDANESE SIGN PANGWISAD */
+	{ 0x01BA1, 0x01BAD }, /* SUNDANESE CONSONANT SIGN PAMINGKAL - SUNDANESE CONSONANT SIGN PASANGAN WA */
+	{ 0x01BE6, 0x01BF3 }, /* BATAK SIGN TOMPI - BATAK PANONGONAN */
+	{ 0x01C24, 0x01C37 }, /* LEPCHA SUBJOINED LETTER YA - LEPCHA SIGN NUKTA */
+	{ 0x01CD0, 0x01CD2 }, /* VEDIC TONE KARSHANA - VEDIC TONE PRENKHA */
+	{ 0x01CD4, 0x01CE8 }, /* VEDIC SIGN YAJURVEDIC MIDLINE SVARITA - VEDIC SIGN VISARGA ANUDATTA WITH TAIL */
+	{ 0x01CED, 0x01CED }, /* VEDIC SIGN TIRYAK */
+	{ 0x01CF4, 0x01CF4 }, /* VEDIC TONE CANDRA ABOVE */
+	{ 0x01CF7, 0x01CF9 }, /* VEDIC SIGN ATIKRAMA - VEDIC TONE DOUBLE RING ABOVE */
+	{ 0x01DC0, 0x01DFF }, /* COMBINING DOTTED GRAVE ACCENT - COMBINING RIGHT ARROWHEAD AND DOWN ARROWHEAD BELOW */
+	{ 0x0200B, 0x0200E }, /* ZERO WIDTH SPACE - LEFT-TO-RIGHT MARK */
+	{ 0x0202A, 0x0202D }, /* LEFT-TO-RIGHT EMBEDDING - LEFT-TO-RIGHT OVERRIDE */
+	{ 0x02060, 0x02064 }, /* WORD JOINER - INVISIBLE PLUS */
+	{ 0x0206A, 0x0206F }, /* INHIBIT SYMMETRIC SWAPPING - NOMINAL DIGIT SHAPES */
+	{ 0x020D0, 0x020F0 }, /* COMBINING LEFT HARPOON ABOVE - COMBINING ASTERISK ABOVE */
+	{ 0x02640, 0x02640 }, /* FEMALE SIGN */
+	{ 0x02642, 0x02642 }, /* MALE SIGN */
+	{ 0x026A7, 0x026A7 }, /* MALE WITH STROKE AND MALE AND FEMALE SIGN */
+	{ 0x02CEF, 0x02CF1 }, /* COPTIC COMBINING NI ABOVE - COPTIC COMBINING SPIRITUS LENIS */
+	{ 0x02D7F, 0x02D7F }, /* TIFINAGH CONSONANT JOINER */
+	{ 0x02DE0, 0x02DFF }, /* COMBINING CYRILLIC LETTER BE - COMBINING CYRILLIC LETTER IOTIFIED BIG YUS */
+	{ 0x0302A, 0x0302F }, /* IDEOGRAPHIC LEVEL TONE MARK - HANGUL DOUBLE DOT TONE MARK */
+	{ 0x03099, 0x0309A }, /* COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK - COMBINING KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK */
+	{ 0x0A66F, 0x0A672 }, /* COMBINING CYRILLIC VZMET - COMBINING CYRILLIC THOUSAND MILLIONS SIGN */
+	{ 0x0A674, 0x0A67D }, /* COMBINING CYRILLIC LETTER UKRAINIAN IE - COMBINING CYRILLIC PAYEROK */
+	{ 0x0A69E, 0x0A69F }, /* COMBINING CYRILLIC LETTER EF - COMBINING CYRILLIC LETTER IOTIFIED E */
+	{ 0x0A6F0, 0x0A6F1 }, /* BAMUM COMBINING MARK KOQNDON - BAMUM COMBINING MARK TUKWENTIS */
+	{ 0x0A802, 0x0A802 }, /* SYLOTI NAGRI SIGN DVISVARA */
+	{ 0x0A806, 0x0A806 }, /* SYLOTI NAGRI SIGN HASANTA */
+	{ 0x0A80B, 0x0A80B }, /* SYLOTI NAGRI SIGN ANUSVARA */
+	{ 0x0A823, 0x0A827 }, /* SYLOTI NAGRI VOWEL SIGN A - SYLOTI NAGRI VOWEL SIGN OO */
+	{ 0x0A82C, 0x0A82C }, /* SYLOTI NAGRI SIGN ALTERNATE HASANTA */
+	{ 0x0A880, 0x0A881 }, /* SAURASHTRA SIGN ANUSVARA - SAURASHTRA SIGN VISARGA */
+	{ 0x0A8B4, 0x0A8C5 }, /* SAURASHTRA CONSONANT SIGN HAARU - SAURASHTRA SIGN CANDRABINDU */
+	{ 0x0A8E0, 0x0A8F1 }, /* COMBINING DEVANAGARI DIGIT ZERO - COMBINING DEVANAGARI SIGN AVAGRAHA */
+	{ 0x0A8FF, 0x0A8FF }, /* DEVANAGARI VOWEL SIGN AY */
+	{ 0x0A926, 0x0A92D }, /* KAYAH LI VOWEL UE - KAYAH LI TONE CALYA PLOPHU */
+	{ 0x0A947, 0x0A953 }, /* REJANG VOWEL SIGN I - REJANG VIRAMA */
+	{ 0x0A980, 0x0A983 }, /* JAVANESE SIGN PANYANGGA - JAVANESE SIGN WIGNYAN */
+	{ 0x0A9B3, 0x0A9C0 }, /* JAVANESE SIGN CECAK TELU - JAVANESE PANGKON */
+	{ 0x0A9E5, 0x0A9E5 }, /* MYANMAR SIGN SHAN SAW */
+	{ 0x0AA29, 0x0AA36 }, /* CHAM VOWEL SIGN AA - CHAM CONSONANT SIGN WA */
+	{ 0x0AA43, 0x0AA43 }, /* CHAM CONSONANT SIGN FINAL NG */
+	{ 0x0AA4C, 0x0AA4D }, /* CHAM CONSONANT SIGN FINAL M - CHAM CONSONANT SIGN FINAL H */
+	{ 0x0AA7B, 0x0AA7D }, /* MYANMAR SIGN PAO KAREN TONE - MYANMAR SIGN TAI LAING TONE-5 */
+	{ 0x0AAB0, 0x0AAB0 }, /* TAI VIET MAI KANG */
+	{ 0x0AAB2, 0x0AAB4 }, /* TAI VIET VOWEL I - TAI VIET VOWEL U */
+	{ 0x0AAB7, 0x0AAB8 }, /* TAI VIET MAI KHIT - TAI VIET VOWEL IA */
+	{ 0x0AABE, 0x0AABF }, /* TAI VIET VOWEL AM - TAI VIET TONE MAI EK */
+	{ 0x0AAC1, 0x0AAC1 }, /* TAI VIET TONE MAI THO */
+	{ 0x0AAEB, 0x0AAEF }, /* MEETEI MAYEK VOWEL SIGN II - MEETEI MAYEK VOWEL SIGN AAU */
+	{ 0x0AAF5, 0x0AAF6 }, /* MEETEI MAYEK VOWEL SIGN VISARGA - MEETEI MAYEK VIRAMA */
+	{ 0x0ABE3, 0x0ABEA }, /* MEETEI MAYEK VOWEL SIGN ONAP - MEETEI MAYEK VOWEL SIGN NUNG */
+	{ 0x0ABEC, 0x0ABED }, /* MEETEI MAYEK LUM IYEK - MEETEI MAYEK APUN IYEK */
+	{ 0x0FB1E, 0x0FB1E }, /* HEBREW POINT JUDEO-SPANISH VARIKA */
+	{ 0x0FE00, 0x0FE0F }, /* VARIATION SELECTOR-1 - VARIATION SELECTOR-16 */
+	{ 0x0FE20, 0x0FE2F }, /* COMBINING LIGATURE LEFT HALF - COMBINING CYRILLIC TITLO RIGHT HALF */
+	{ 0x0FEFF, 0x0FEFF }, /* ZERO WIDTH NO-BREAK SPACE */
+	{ 0x0FFF9, 0x0FFFB }, /* INTERLINEAR ANNOTATION ANCHOR - INTERLINEAR ANNOTATION TERMINATOR */
+	{ 0x101FD, 0x101FD }, /* U+101FD */
+	{ 0x102E0, 0x102E0 }, /* U+102E0 */
+	{ 0x10376, 0x1037A }, /* U+10376 - U+1037A */
+	{ 0x10A01, 0x10A03 }, /* U+10A01 - U+10A03 */
+	{ 0x10A05, 0x10A06 }, /* U+10A05 - U+10A06 */
+	{ 0x10A0C, 0x10A0F }, /* U+10A0C - U+10A0F */
+	{ 0x10A38, 0x10A3A }, /* U+10A38 - U+10A3A */
+	{ 0x10A3F, 0x10A3F }, /* U+10A3F */
+	{ 0x10AE5, 0x10AE6 }, /* U+10AE5 - U+10AE6 */
+	{ 0x10D24, 0x10D27 }, /* U+10D24 - U+10D27 */
+	{ 0x10D69, 0x10D6D }, /* U+10D69 - U+10D6D */
+	{ 0x10EAB, 0x10EAC }, /* U+10EAB - U+10EAC */
+	{ 0x10EFC, 0x10EFF }, /* U+10EFC - U+10EFF */
+	{ 0x10F46, 0x10F50 }, /* U+10F46 - U+10F50 */
+	{ 0x10F82, 0x10F85 }, /* U+10F82 - U+10F85 */
+	{ 0x11000, 0x11002 }, /* U+11000 - U+11002 */
+	{ 0x11038, 0x11046 }, /* U+11038 - U+11046 */
+	{ 0x11070, 0x11070 }, /* U+11070 */
+	{ 0x11073, 0x11074 }, /* U+11073 - U+11074 */
+	{ 0x1107F, 0x11082 }, /* U+1107F - U+11082 */
+	{ 0x110B0, 0x110BA }, /* U+110B0 - U+110BA */
+	{ 0x110BD, 0x110BD }, /* U+110BD */
+	{ 0x110C2, 0x110C2 }, /* U+110C2 */
+	{ 0x110CD, 0x110CD }, /* U+110CD */
+	{ 0x11100, 0x11102 }, /* U+11100 - U+11102 */
+	{ 0x11127, 0x11134 }, /* U+11127 - U+11134 */
+	{ 0x11145, 0x11146 }, /* U+11145 - U+11146 */
+	{ 0x11173, 0x11173 }, /* U+11173 */
+	{ 0x11180, 0x11182 }, /* U+11180 - U+11182 */
+	{ 0x111B3, 0x111C0 }, /* U+111B3 - U+111C0 */
+	{ 0x111C9, 0x111CC }, /* U+111C9 - U+111CC */
+	{ 0x111CE, 0x111CF }, /* U+111CE - U+111CF */
+	{ 0x1122C, 0x11237 }, /* U+1122C - U+11237 */
+	{ 0x1123E, 0x1123E }, /* U+1123E */
+	{ 0x11241, 0x11241 }, /* U+11241 */
+	{ 0x112DF, 0x112EA }, /* U+112DF - U+112EA */
+	{ 0x11300, 0x11303 }, /* U+11300 - U+11303 */
+	{ 0x1133B, 0x1133C }, /* U+1133B - U+1133C */
+	{ 0x1133E, 0x11344 }, /* U+1133E - U+11344 */
+	{ 0x11347, 0x11348 }, /* U+11347 - U+11348 */
+	{ 0x1134B, 0x1134D }, /* U+1134B - U+1134D */
+	{ 0x11357, 0x11357 }, /* U+11357 */
+	{ 0x11362, 0x11363 }, /* U+11362 - U+11363 */
+	{ 0x11366, 0x1136C }, /* U+11366 - U+1136C */
+	{ 0x11370, 0x11374 }, /* U+11370 - U+11374 */
+	{ 0x113B8, 0x113C0 }, /* U+113B8 - U+113C0 */
+	{ 0x113C2, 0x113C2 }, /* U+113C2 */
+	{ 0x113C5, 0x113C5 }, /* U+113C5 */
+	{ 0x113C7, 0x113CA }, /* U+113C7 - U+113CA */
+	{ 0x113CC, 0x113D0 }, /* U+113CC - U+113D0 */
+	{ 0x113D2, 0x113D2 }, /* U+113D2 */
+	{ 0x113E1, 0x113E2 }, /* U+113E1 - U+113E2 */
+	{ 0x11435, 0x11446 }, /* U+11435 - U+11446 */
+	{ 0x1145E, 0x1145E }, /* U+1145E */
+	{ 0x114B0, 0x114C3 }, /* U+114B0 - U+114C3 */
+	{ 0x115AF, 0x115B5 }, /* U+115AF - U+115B5 */
+	{ 0x115B8, 0x115C0 }, /* U+115B8 - U+115C0 */
+	{ 0x115DC, 0x115DD }, /* U+115DC - U+115DD */
+	{ 0x11630, 0x11640 }, /* U+11630 - U+11640 */
+	{ 0x116AB, 0x116B7 }, /* U+116AB - U+116B7 */
+	{ 0x1171D, 0x1172B }, /* U+1171D - U+1172B */
+	{ 0x1182C, 0x1183A }, /* U+1182C - U+1183A */
+	{ 0x11930, 0x11935 }, /* U+11930 - U+11935 */
+	{ 0x11937, 0x11938 }, /* U+11937 - U+11938 */
+	{ 0x1193B, 0x1193E }, /* U+1193B - U+1193E */
+	{ 0x11940, 0x11940 }, /* U+11940 */
+	{ 0x11942, 0x11943 }, /* U+11942 - U+11943 */
+	{ 0x119D1, 0x119D7 }, /* U+119D1 - U+119D7 */
+	{ 0x119DA, 0x119E0 }, /* U+119DA - U+119E0 */
+	{ 0x119E4, 0x119E4 }, /* U+119E4 */
+	{ 0x11A01, 0x11A0A }, /* U+11A01 - U+11A0A */
+	{ 0x11A33, 0x11A39 }, /* U+11A33 - U+11A39 */
+	{ 0x11A3B, 0x11A3E }, /* U+11A3B - U+11A3E */
+	{ 0x11A47, 0x11A47 }, /* U+11A47 */
+	{ 0x11A51, 0x11A5B }, /* U+11A51 - U+11A5B */
+	{ 0x11A8A, 0x11A99 }, /* U+11A8A - U+11A99 */
+	{ 0x11C2F, 0x11C36 }, /* U+11C2F - U+11C36 */
+	{ 0x11C38, 0x11C3F }, /* U+11C38 - U+11C3F */
+	{ 0x11C92, 0x11CA7 }, /* U+11C92 - U+11CA7 */
+	{ 0x11CA9, 0x11CB6 }, /* U+11CA9 - U+11CB6 */
+	{ 0x11D31, 0x11D36 }, /* U+11D31 - U+11D36 */
+	{ 0x11D3A, 0x11D3A }, /* U+11D3A */
+	{ 0x11D3C, 0x11D3D }, /* U+11D3C - U+11D3D */
+	{ 0x11D3F, 0x11D45 }, /* U+11D3F - U+11D45 */
+	{ 0x11D47, 0x11D47 }, /* U+11D47 */
+	{ 0x11D8A, 0x11D8E }, /* U+11D8A - U+11D8E */
+	{ 0x11D90, 0x11D91 }, /* U+11D90 - U+11D91 */
+	{ 0x11D93, 0x11D97 }, /* U+11D93 - U+11D97 */
+	{ 0x11EF3, 0x11EF6 }, /* U+11EF3 - U+11EF6 */
+	{ 0x11F00, 0x11F01 }, /* U+11F00 - U+11F01 */
+	{ 0x11F03, 0x11F03 }, /* U+11F03 */
+	{ 0x11F34, 0x11F3A }, /* U+11F34 - U+11F3A */
+	{ 0x11F3E, 0x11F42 }, /* U+11F3E - U+11F42 */
+	{ 0x11F5A, 0x11F5A }, /* U+11F5A */
+	{ 0x13430, 0x13440 }, /* U+13430 - U+13440 */
+	{ 0x13447, 0x13455 }, /* U+13447 - U+13455 */
+	{ 0x1611E, 0x1612F }, /* U+1611E - U+1612F */
+	{ 0x16AF0, 0x16AF4 }, /* U+16AF0 - U+16AF4 */
+	{ 0x16B30, 0x16B36 }, /* U+16B30 - U+16B36 */
+	{ 0x16F4F, 0x16F4F }, /* U+16F4F */
+	{ 0x16F51, 0x16F87 }, /* U+16F51 - U+16F87 */
+	{ 0x16F8F, 0x16F92 }, /* U+16F8F - U+16F92 */
+	{ 0x16FE4, 0x16FE4 }, /* U+16FE4 */
+	{ 0x16FF0, 0x16FF1 }, /* U+16FF0 - U+16FF1 */
+	{ 0x1BC9D, 0x1BC9E }, /* U+1BC9D - U+1BC9E */
+	{ 0x1BCA0, 0x1BCA3 }, /* U+1BCA0 - U+1BCA3 */
+	{ 0x1CF00, 0x1CF2D }, /* U+1CF00 - U+1CF2D */
+	{ 0x1CF30, 0x1CF46 }, /* U+1CF30 - U+1CF46 */
+	{ 0x1D165, 0x1D169 }, /* U+1D165 - U+1D169 */
+	{ 0x1D16D, 0x1D182 }, /* U+1D16D - U+1D182 */
+	{ 0x1D185, 0x1D18B }, /* U+1D185 - U+1D18B */
+	{ 0x1D1AA, 0x1D1AD }, /* U+1D1AA - U+1D1AD */
+	{ 0x1D242, 0x1D244 }, /* U+1D242 - U+1D244 */
+	{ 0x1DA00, 0x1DA36 }, /* U+1DA00 - U+1DA36 */
+	{ 0x1DA3B, 0x1DA6C }, /* U+1DA3B - U+1DA6C */
+	{ 0x1DA75, 0x1DA75 }, /* U+1DA75 */
+	{ 0x1DA84, 0x1DA84 }, /* U+1DA84 */
+	{ 0x1DA9B, 0x1DA9F }, /* U+1DA9B - U+1DA9F */
+	{ 0x1DAA1, 0x1DAAF }, /* U+1DAA1 - U+1DAAF */
+	{ 0x1E000, 0x1E006 }, /* U+1E000 - U+1E006 */
+	{ 0x1E008, 0x1E018 }, /* U+1E008 - U+1E018 */
+	{ 0x1E01B, 0x1E021 }, /* U+1E01B - U+1E021 */
+	{ 0x1E023, 0x1E024 }, /* U+1E023 - U+1E024 */
+	{ 0x1E026, 0x1E02A }, /* U+1E026 - U+1E02A */
+	{ 0x1E08F, 0x1E08F }, /* U+1E08F */
+	{ 0x1E130, 0x1E136 }, /* U+1E130 - U+1E136 */
+	{ 0x1E2AE, 0x1E2AE }, /* U+1E2AE */
+	{ 0x1E2EC, 0x1E2EF }, /* U+1E2EC - U+1E2EF */
+	{ 0x1E4EC, 0x1E4EF }, /* U+1E4EC - U+1E4EF */
+	{ 0x1E5EE, 0x1E5EF }, /* U+1E5EE - U+1E5EF */
+	{ 0x1E8D0, 0x1E8D6 }, /* U+1E8D0 - U+1E8D6 */
+	{ 0x1E944, 0x1E94A }, /* U+1E944 - U+1E94A */
+	{ 0x1F3FB, 0x1F3FF }, /* U+1F3FB - U+1F3FF */
+	{ 0x1F9B0, 0x1F9B3 }, /* U+1F9B0 - U+1F9B3 */
+	{ 0xE0001, 0xE0001 }, /* U+E0001 */
+	{ 0xE0020, 0xE007F }, /* U+E0020 - U+E007F */
+	{ 0xE0100, 0xE01EF }, /* U+E0100 - U+E01EF */
+};
+
+/* Double-width character ranges */
+static const struct interval double_width_ranges[] = {
+	{ 0x01100, 0x0115F }, /* HANGUL CHOSEONG KIYEOK - HANGUL CHOSEONG FILLER */
+	{ 0x0231A, 0x0231B }, /* WATCH - HOURGLASS */
+	{ 0x02329, 0x0232A }, /* LEFT-POINTING ANGLE BRACKET - RIGHT-POINTING ANGLE BRACKET */
+	{ 0x023E9, 0x023EC }, /* BLACK RIGHT-POINTING DOUBLE TRIANGLE - BLACK DOWN-POINTING DOUBLE TRIANGLE */
+	{ 0x023F0, 0x023F0 }, /* ALARM CLOCK */
+	{ 0x023F3, 0x023F3 }, /* HOURGLASS WITH FLOWING SAND */
+	{ 0x025FD, 0x025FE }, /* WHITE MEDIUM SMALL SQUARE - BLACK MEDIUM SMALL SQUARE */
+	{ 0x02614, 0x02615 }, /* UMBRELLA WITH RAIN DROPS - HOT BEVERAGE */
+	{ 0x02630, 0x02637 }, /* TRIGRAM FOR HEAVEN - TRIGRAM FOR EARTH */
+	{ 0x02648, 0x02653 }, /* ARIES - PISCES */
+	{ 0x0267F, 0x0267F }, /* WHEELCHAIR SYMBOL */
+	{ 0x0268A, 0x0268F }, /* MONOGRAM FOR YANG - DIGRAM FOR GREATER YIN */
+	{ 0x02693, 0x02693 }, /* ANCHOR */
+	{ 0x026A1, 0x026A1 }, /* HIGH VOLTAGE SIGN */
+	{ 0x026AA, 0x026AB }, /* MEDIUM WHITE CIRCLE - MEDIUM BLACK CIRCLE */
+	{ 0x026BD, 0x026BE }, /* SOCCER BALL - BASEBALL */
+	{ 0x026C4, 0x026C5 }, /* SNOWMAN WITHOUT SNOW - SUN BEHIND CLOUD */
+	{ 0x026CE, 0x026CE }, /* OPHIUCHUS */
+	{ 0x026D4, 0x026D4 }, /* NO ENTRY */
+	{ 0x026EA, 0x026EA }, /* CHURCH */
+	{ 0x026F2, 0x026F3 }, /* FOUNTAIN - FLAG IN HOLE */
+	{ 0x026F5, 0x026F5 }, /* SAILBOAT */
+	{ 0x026FA, 0x026FA }, /* TENT */
+	{ 0x026FD, 0x026FD }, /* FUEL PUMP */
+	{ 0x02705, 0x02705 }, /* WHITE HEAVY CHECK MARK */
+	{ 0x0270A, 0x0270B }, /* RAISED FIST - RAISED HAND */
+	{ 0x02728, 0x02728 }, /* SPARKLES */
+	{ 0x0274C, 0x0274C }, /* CROSS MARK */
+	{ 0x0274E, 0x0274E }, /* NEGATIVE SQUARED CROSS MARK */
+	{ 0x02753, 0x02755 }, /* BLACK QUESTION MARK ORNAMENT - WHITE EXCLAMATION MARK ORNAMENT */
+	{ 0x02757, 0x02757 }, /* HEAVY EXCLAMATION MARK SYMBOL */
+	{ 0x02795, 0x02797 }, /* HEAVY PLUS SIGN - HEAVY DIVISION SIGN */
+	{ 0x027B0, 0x027B0 }, /* CURLY LOOP */
+	{ 0x027BF, 0x027BF }, /* DOUBLE CURLY LOOP */
+	{ 0x02B1B, 0x02B1C }, /* BLACK LARGE SQUARE - WHITE LARGE SQUARE */
+	{ 0x02B50, 0x02B50 }, /* WHITE MEDIUM STAR */
+	{ 0x02B55, 0x02B55 }, /* HEAVY LARGE CIRCLE */
+	{ 0x02E80, 0x02E99 }, /* CJK RADICAL REPEAT - CJK RADICAL RAP */
+	{ 0x02E9B, 0x02EF3 }, /* CJK RADICAL CHOKE - CJK RADICAL C-SIMPLIFIED TURTLE */
+	{ 0x02F00, 0x02FD5 }, /* KANGXI RADICAL ONE - KANGXI RADICAL FLUTE */
+	{ 0x02FF0, 0x03029 }, /* IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT - HANGZHOU NUMERAL NINE */
+	{ 0x03030, 0x0303E }, /* WAVY DASH - IDEOGRAPHIC VARIATION INDICATOR */
+	{ 0x03041, 0x03096 }, /* HIRAGANA LETTER SMALL A - HIRAGANA LETTER SMALL KE */
+	{ 0x0309B, 0x030FF }, /* KATAKANA-HIRAGANA VOICED SOUND MARK - KATAKANA DIGRAPH KOTO */
+	{ 0x03105, 0x0312F }, /* BOPOMOFO LETTER B - BOPOMOFO LETTER NN */
+	{ 0x03131, 0x0318E }, /* HANGUL LETTER KIYEOK - HANGUL LETTER ARAEAE */
+	{ 0x03190, 0x031E5 }, /* IDEOGRAPHIC ANNOTATION LINKING MARK - CJK STROKE SZP */
+	{ 0x031EF, 0x0321E }, /* IDEOGRAPHIC DESCRIPTION CHARACTER SUBTRACTION - PARENTHESIZED KOREAN CHARACTER O HU */
+	{ 0x03220, 0x03247 }, /* PARENTHESIZED IDEOGRAPH ONE - CIRCLED IDEOGRAPH KOTO */
+	{ 0x03250, 0x0A48C }, /* PARTNERSHIP SIGN - YI SYLLABLE YYR */
+	{ 0x0A490, 0x0A4C6 }, /* YI RADICAL QOT - YI RADICAL KE */
+	{ 0x0A960, 0x0A97C }, /* HANGUL CHOSEONG TIKEUT-MIEUM - HANGUL CHOSEONG SSANGYEORINHIEUH */
+	{ 0x0AC00, 0x0D7A3 }, /* HANGUL SYLLABLE GA - HANGUL SYLLABLE HIH */
+	{ 0x0F900, 0x0FAFF }, /* U+0F900 - U+0FAFF */
+	{ 0x0FE10, 0x0FE19 }, /* PRESENTATION FORM FOR VERTICAL COMMA - PRESENTATION FORM FOR VERTICAL HORIZONTAL ELLIPSIS */
+	{ 0x0FE30, 0x0FE52 }, /* PRESENTATION FORM FOR VERTICAL TWO DOT LEADER - SMALL FULL STOP */
+	{ 0x0FE54, 0x0FE66 }, /* SMALL SEMICOLON - SMALL EQUALS SIGN */
+	{ 0x0FE68, 0x0FE6B }, /* SMALL REVERSE SOLIDUS - SMALL COMMERCIAL AT */
+	{ 0x0FF01, 0x0FF60 }, /* FULLWIDTH EXCLAMATION MARK - FULLWIDTH RIGHT WHITE PARENTHESIS */
+	{ 0x0FFE0, 0x0FFE6 }, /* FULLWIDTH CENT SIGN - FULLWIDTH WON SIGN */
+	{ 0x16FE0, 0x16FE3 }, /* U+16FE0 - U+16FE3 */
+	{ 0x17000, 0x187F7 }, /* U+17000 - U+187F7 */
+	{ 0x18800, 0x18CD5 }, /* U+18800 - U+18CD5 */
+	{ 0x18CFF, 0x18D08 }, /* U+18CFF - U+18D08 */
+	{ 0x1AFF0, 0x1AFF3 }, /* U+1AFF0 - U+1AFF3 */
+	{ 0x1AFF5, 0x1AFFB }, /* U+1AFF5 - U+1AFFB */
+	{ 0x1AFFD, 0x1AFFE }, /* U+1AFFD - U+1AFFE */
+	{ 0x1B000, 0x1B122 }, /* U+1B000 - U+1B122 */
+	{ 0x1B132, 0x1B132 }, /* U+1B132 */
+	{ 0x1B150, 0x1B152 }, /* U+1B150 - U+1B152 */
+	{ 0x1B155, 0x1B155 }, /* U+1B155 */
+	{ 0x1B164, 0x1B167 }, /* U+1B164 - U+1B167 */
+	{ 0x1B170, 0x1B2FB }, /* U+1B170 - U+1B2FB */
+	{ 0x1D300, 0x1D356 }, /* U+1D300 - U+1D356 */
+	{ 0x1D360, 0x1D376 }, /* U+1D360 - U+1D376 */
+	{ 0x1F000, 0x1F02F }, /* U+1F000 - U+1F02F */
+	{ 0x1F0A0, 0x1F0FF }, /* U+1F0A0 - U+1F0FF */
+	{ 0x1F18E, 0x1F18E }, /* U+1F18E */
+	{ 0x1F191, 0x1F19A }, /* U+1F191 - U+1F19A */
+	{ 0x1F200, 0x1F202 }, /* U+1F200 - U+1F202 */
+	{ 0x1F210, 0x1F23B }, /* U+1F210 - U+1F23B */
+	{ 0x1F240, 0x1F248 }, /* U+1F240 - U+1F248 */
+	{ 0x1F250, 0x1F251 }, /* U+1F250 - U+1F251 */
+	{ 0x1F260, 0x1F265 }, /* U+1F260 - U+1F265 */
+	{ 0x1F300, 0x1F3FA }, /* U+1F300 - U+1F3FA */
+	{ 0x1F400, 0x1F64F }, /* U+1F400 - U+1F64F */
+	{ 0x1F680, 0x1F9AF }, /* U+1F680 - U+1F9AF */
+	{ 0x1F9B4, 0x1FAFF }, /* U+1F9B4 - U+1FAFF */
+	{ 0x20000, 0x2FFFD }, /* U+20000 - U+2FFFD */
+	{ 0x30000, 0x3FFFD }, /* U+30000 - U+3FFFD */
+};
+
+
+static int ucs_cmp(const void *key, const void *element)
 {
 	uint32_t cp = *(uint32_t *)key;
-	struct interval e = *(struct interval *) elt;
+	const struct interval *e = element;
 
-	if (cp > e.last)
+	if (cp > e->last)
 		return 1;
-	else if (cp < e.first)
+	if (cp < e->first)
 		return -1;
 	return 0;
 }
 
-static const struct interval double_width[] = {
-	{ 0x1100, 0x115F }, { 0x2329, 0x232A }, { 0x2E80, 0x303E },
-	{ 0x3040, 0xA4CF }, { 0xAC00, 0xD7A3 }, { 0xF900, 0xFAFF },
-	{ 0xFE10, 0xFE19 }, { 0xFE30, 0xFE6F }, { 0xFF00, 0xFF60 },
-	{ 0xFFE0, 0xFFE6 }, { 0x20000, 0x2FFFD }, { 0x30000, 0x3FFFD }
-};
-
-bool ucs_is_double_width(uint32_t cp)
+static bool is_in_interval(uint32_t cp, const struct interval *intervals, size_t count)
 {
-	if (cp < double_width[0].first ||
-	    cp > double_width[ARRAY_SIZE(double_width) - 1].last)
+	if (cp < intervals[0].first || cp > intervals[count - 1].last)
 		return false;
 
-	return bsearch(&cp, double_width, ARRAY_SIZE(double_width),
-		       sizeof(struct interval), ucs_cmp) != NULL;
+	return __inline_bsearch(&cp, intervals, count,
+				sizeof(*intervals), ucs_cmp) != NULL;
+}
+
+/**
+ * Determine if a Unicode code point is zero-width.
+ *
+ * @param ucs: Unicode code point (UCS-4)
+ * Return: true if the character is zero-width, false otherwise
+ */
+bool ucs_is_zero_width(uint32_t cp)
+{
+	return is_in_interval(cp, zero_width_ranges, ARRAY_SIZE(zero_width_ranges));
+}
+
+/**
+ * Determine if a Unicode code point is double-width.
+ *
+ * @param ucs: Unicode code point (UCS-4)
+ * Return: true if the character is double-width, false otherwise
+ */
+bool ucs_is_double_width(uint32_t cp)
+{
+	return is_in_interval(cp, double_width_ranges, ARRAY_SIZE(double_width_ranges));
 }
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 7d778752dc..b3a9118666 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -29,11 +29,7 @@ u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
 bool ucs_is_double_width(uint32_t cp);
-static inline bool ucs_is_zero_width(uint32_t cp)
-{
-	/* coming soon */
-	return false;
-}
+bool ucs_is_zero_width(uint32_t cp);
 #else
 static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
 		bool use_unicode)
-- 
2.49.0


