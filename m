Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB358251D75
	for <lists+linux-serial@lfdr.de>; Tue, 25 Aug 2020 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHYQtM (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 25 Aug 2020 12:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYQtM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Aug 2020 12:49:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4AFC061574;
        Tue, 25 Aug 2020 09:49:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ep8so1529064pjb.3;
        Tue, 25 Aug 2020 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOmXAx+g6AYdmKcdtOAJb/8DkoFuv5X12lGh19wTah0=;
        b=LqBYNQvYi+P0BNF3Y12On1ZZO83Cj2Ctnu1HX1scg2WJpZ2vCQ3YXvazQgyvJpa9hw
         6mAlLdbF1SqQfhzJut9yZ+Y6QsnQ7Y2J+1CK19IL/ZyLJcs3H4VQydH2SXLSI8BSuRiJ
         JKNVr2T4J6YyMvAxxwrZmOmEdBQ2FTH/lZTKYe61H9FFuRbdqTb/GlPIYixoOAIB52oh
         vRBftreDlVMP6H/8H/q/c5ss+l/2FgZAD8KtWu6eZbiLkA0KwSz0LveVpnRrrA43Gspa
         O6V+vt8vmQwA152KJ9sM8CVs7FFv4fTSBLlt/hYbILOLOcDHb+GbD8ynt5hMebg95lvH
         MjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOmXAx+g6AYdmKcdtOAJb/8DkoFuv5X12lGh19wTah0=;
        b=ok3yskuzIlC0jQu0oC+ob7K2CND3Y9Qo5IRrggKg1kUIROUAUJQITjxKz84XA2n7Ww
         AbroTYh/eqjyG9ECHPfmy+6bbghpc9oGNeRhQb5Tq5+DaSWEDycsni3qCc2pliKC1rTF
         NgqXr+Phjl2mP8oP5x4g/0LWFISGTI9ry1hxKPhFaFI687PPqMtZi3X/0lPIcW7586mb
         2o95frlHQCcdSPjvhkAPnJT+dZvyzpNb4vt/7GFlPEFyNcUIIbWJiA3vIzv7+lYmoill
         YL4P3mPPUbtVDLI8SYRNveJf5oa2Pl0SxAnoe/0KEKo4I5lraL4pH1Pg32mbuVb8OkqA
         KvRw==
X-Gm-Message-State: AOAM530VwLybmlz3XS3S3sPmXCXw55P0FPM0/e+2ewcpQOTPyYi0X3Vx
        5CWqxVpux6VqYkgHYCwtNg==
X-Google-Smtp-Source: ABdhPJxJniaH/TLwosXRVvYOc5w1FpSJBIScyt++FcpHV0j2yRV/ev3rIRUqe6DE4jbPsVTPpLuqHg==
X-Received: by 2002:a17:90a:9103:: with SMTP id k3mr2353650pjo.4.1598374151495;
        Tue, 25 Aug 2020 09:49:11 -0700 (PDT)
Received: from localhost.localdomain ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id t5sm3314443pji.51.2020.08.25.09.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:49:11 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     jslaby@suse.cz
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 15/16] vc_screen: extract vcs_read_buf_header
Date:   Tue, 25 Aug 2020 12:48:04 -0400
Message-Id: <20200825164804.860743-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818085706.12163-15-jslaby@suse.cz>
References: <20200818085706.12163-15-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all,

Link: https://syzkaller.appspot.com/bug?id=f332576321998d36cd07d09c9c1268cfed1895c9

As reported by syzbot, vcs_read_buf() is overflowing `con_buf16`, since
this patch removed the following check:

-		if (count > CON_BUF_SIZE) {
-			count = CON_BUF_SIZE;
-			filled = count - pos;
-		}

Decreasing `count` by `min(HEADER_SIZE - pos, count)` bypasses this check.
Additionally, this patch also removed updates to `skip` and `filled`.

What should we do in order to fix it?

Thank you,
Peilin Ye
