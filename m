Return-Path: <linux-serial+bounces-421-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81646802704
	for <lists+linux-serial@lfdr.de>; Sun,  3 Dec 2023 20:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A954B209A4
	for <lists+linux-serial@lfdr.de>; Sun,  3 Dec 2023 19:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D971803D;
	Sun,  3 Dec 2023 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1oDnjih"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E501FD9;
	Sun,  3 Dec 2023 11:33:50 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d81c24cef2so5024297b3.2;
        Sun, 03 Dec 2023 11:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632028; x=1702236828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fI2gIQbcbp1xK3E243LxY/3e2AZOGk62oXabUWt699c=;
        b=D1oDnjihjFt1NHRU1aNoMMKbwnitMybN5zkaAK8YapPY7UBi5XJwS9loqJSDYDgWYH
         SJSTqlTba/opk8vhi+RKQqSVrWbqyvMm384B0yWPkL68Xci4l4/diHbEanfHs1xThS/b
         SgYTq5SoleUHiBeAok6InsNS6/fqIPYET3T4+LGOHDgy8+0Cdr9vpS7ALdJXzEuJFMX1
         dXNcF0MWQGFqJQqQ8/HRUo3WNRUC4haD1qFTKx3VJcg16AkQBl/ZOPZ2rXvY2I2goX9h
         cbioeSa8YuyvDBMmtFxX/Mm+fTMWl13fvHFQw4yfBYEJoIOT8B8YZPXZcD6WithBVjPL
         DSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632028; x=1702236828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fI2gIQbcbp1xK3E243LxY/3e2AZOGk62oXabUWt699c=;
        b=UDuJwFo7MMYRA8cAscP6eGT76G2gTQjzIRmCOJ4McvPzF8AAurqaA892FC3hRnYYGy
         Px+QeUddFEtLqlfan1rCsFfqf3UagXMhy1OP5TGEkE4jMrQR4bbxXy14yQfVIX4/7cM3
         L1QE1N+TKBK6cVFDqv5frdXfDfyJIKbnTnwyAKmRBr60ciOryq0LRmVumqev7eME4kL/
         nzsqs+lDLT0lex/h1CW2aXrTDu7y28C8mruYIqqGEiqheOEeyLX3ejMIlJPW06IYF/8v
         9NFFXtwh+4xSnMGVRpiveQN+pK4ND4nZMFutDiBwaAhk7TxtM2ccMmtltX5eldEWrfMO
         WBIQ==
X-Gm-Message-State: AOJu0Yy87YY1Q08P7GALODixhhojwJAbXjP8+jCnZjan3JYA4BPcR38w
	j00xw15SlXeLnUgOWsJWoBfL4Pd0hA491g==
X-Google-Smtp-Source: AGHT+IGgytAsu4EJ0I9DXO0S8f5gEepQDe15IU+p3MOcFTWlmzPKCCUKJC6jF/ah1xFi4Vxuf7Xqfg==
X-Received: by 2002:a81:ae24:0:b0:5d7:1940:f3cf with SMTP id m36-20020a81ae24000000b005d71940f3cfmr2099899ywh.55.1701632028237;
        Sun, 03 Dec 2023 11:33:48 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id d3-20020a0df403000000b005b34d8b33ffsm2760394ywf.119.2023.12.03.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:47 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 22/35] tty: nozomi: optimize interrupt_handler()
Date: Sun,  3 Dec 2023 11:32:54 -0800
Message-Id: <20231203193307.542794-21-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In exit path of interrupt_handler(), dc->flip map is traversed bit by
bit to find and clear set bits and call tty_flip_buffer_push() for
corresponding ports.

We can do it better by using for_each_test_and_clear_bit(), because it
skips already clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/tty/nozomi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 02cd40147b3a..de0503247391 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1220,9 +1220,8 @@ static irqreturn_t interrupt_handler(int irq, void *dev_id)
 exit_handler:
 	spin_unlock(&dc->spin_mutex);
 
-	for (a = 0; a < NOZOMI_MAX_PORTS; a++)
-		if (test_and_clear_bit(a, &dc->flip))
-			tty_flip_buffer_push(&dc->port[a].port);
+	for_each_test_and_clear_bit(a, &dc->flip, NOZOMI_MAX_PORTS)
+		tty_flip_buffer_push(&dc->port[a].port);
 
 	return IRQ_HANDLED;
 none:
-- 
2.40.1


