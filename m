Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B467D9AF9
	for <lists+linux-serial@lfdr.de>; Fri, 27 Oct 2023 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbjJ0OPu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 27 Oct 2023 10:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346112AbjJ0OPs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Oct 2023 10:15:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D1FA
        for <linux-serial@vger.kernel.org>; Fri, 27 Oct 2023 07:15:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da04776a869so1516415276.0
        for <linux-serial@vger.kernel.org>; Fri, 27 Oct 2023 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698416143; x=1699020943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6Wogm78zGHr7c0TI3PksAkvURXKXnXYdkqP8SNCZYk=;
        b=DfqnykrRRsemYMpSbbBPoLlsSnhvYQLsPalSNTBYfXatcydc7SsP0B8iKlkaRZjpM2
         WgOPFQRfXGF5SRuk27LEGPXqp20WLysPBolURJTovfK20snG8LCT7QvMQG6DG7LqiNJX
         Ltg2Ti72MGXnwSCGaTITjDffo6o1luHWFhtXKKB1GE/Sur9XJBSTiSbvtglQMJFAeBDD
         FpC9e/WbthpwMwlWPTVjrCQyrS/SWp0vbg+MUyjirmHoexvNpYSOfbdV6IRQi+KXWgYB
         Fu90ff2UbYTSJtF0Av0JgnkRC7TFetTWqTfa5UVF52dqX0Nwfs4HrimnvZQ11cQBj91V
         jUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416143; x=1699020943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6Wogm78zGHr7c0TI3PksAkvURXKXnXYdkqP8SNCZYk=;
        b=Lw9qc7Y2ZVKBisuqjKT1U6oA2Xm+NI2ftOuXnLIeM0rEAoI6p9kOFen/Ssg4xdIr0O
         E34qzXUnc8wkBIZtmYTgFdkom99rR+gHGskg6+Wz7px4fFFMx27naSj04cXZWiHHHBSL
         +esoShRipKuZ2xQBgmg3zuly+bDoT5nX0a9OwzoZ9dPuwH/HE11y84HY8IEQR3l098Xs
         UyTovicfb2tU1YbuEcItQ4Lzx7RZhWxf5CNf+gM7GwgT4GyaWlKk6JyCYXY3znxFVFL6
         lEClKdV+2B7HoU2I0UV+rxilUSo0AdfALTwR1Trca8esKugdBeWNpnF2rnafWobr+FzV
         mdvQ==
X-Gm-Message-State: AOJu0YzaVVMk8/BDm//bWqYxEtm0gM2lpKOk96hQDky+6rDdlLh/J0PX
        WtL9f2I3SVg3YWUmy+HQReaRGoynhvBIZlrvyGyZ
X-Google-Smtp-Source: AGHT+IGiBegNQMjPo+jvPjsDZNLTWLXmCuAd+U3t/Sn0ndd2lrZtgBb1WDoAF/L8yK4wq+W14D6hcyRzXdR+nc65ltAp
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:aa07:0:b0:da0:c584:defe with
 SMTP id s7-20020a25aa07000000b00da0c584defemr44118ybi.13.1698416142832; Fri,
 27 Oct 2023 07:15:42 -0700 (PDT)
Date:   Fri, 27 Oct 2023 19:45:34 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027141534.3723781-1-vamshigajjela@google.com>
Subject: [PATCH v4 3/3] serial: core: Update uart_poll_timeout() function to
 return unsigned long
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The function uart_fifo_timeout() returns an unsigned long value, which
is the number of jiffies. Therefore, change the variable timeout in the
function uart_poll_timeout() from int to unsigned long.
Change the return type of the function uart_poll_timeout() from int to
unsigned long to be consistent with the type of timeout values.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
v4:
- author name in capitals to lowercase
v3:
- updated description
v2:
- unsigned long instead of unsigned int
- added () after function name in short log
- updated description

 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..6916a1d7e477 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 }
 
 /* Base timer interval for polling */
-static inline int uart_poll_timeout(struct uart_port *port)
+static inline unsigned long uart_poll_timeout(struct uart_port *port)
 {
-	int timeout = uart_fifo_timeout(port);
+	unsigned long timeout = uart_fifo_timeout(port);
 
 	return timeout > 6 ? (timeout / 2 - 2) : 1;
 }
-- 
2.42.0.820.g83a721a137-goog

