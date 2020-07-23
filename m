Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF03122AEC9
	for <lists+linux-serial@lfdr.de>; Thu, 23 Jul 2020 14:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGWMOr (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 23 Jul 2020 08:14:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35790 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWMOo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 08:14:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id u12so3151143lff.2;
        Thu, 23 Jul 2020 05:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rH77oDgMAQJxZnttfdKkk4QTDEhbVsA8vngN2ZlyQT0=;
        b=DyRkoqcUem8xb3i5NgpL1hM7GucESxDQ1aZdSKtIz9ZDyImEcNYedmiAjMHghub1aT
         Ly8PHFc64safBEmgWr5vnmwGM9prQvWWV7jw3GFU0bqcBuw0zFLlhfJJFkkUtG56s2TH
         PgQJ3DQ3XetwFixTsMa9nVB5KZqf5KcFez1hQTq7t06tLBK9Gr8VZlr+mX8txDNkwfCE
         dhWtIHXghk4EtCGG6CbAG6PBCnUYW0zlU0qTXDoT1V6oQJgcsYDVuKO5K2JmRVi2ntRF
         kAW6WaBqYTSUkOtKIM/n6eNrKm3/Ygcx3nDzJ5yixT7duhi+bvfM4hTgnT7Eba0XVlKZ
         sulw==
X-Gm-Message-State: AOAM533iuWCnrLUAKxzrRKTrd5m4pP1IumuSnPOGL6SUYB2+j5+8n409
        n5bkzrIa9vBPEW49qm+8SsEcJqP3
X-Google-Smtp-Source: ABdhPJxkMh9MBsG8HGKMrOw0tN+Z+JuYyw5Fm26lnVczdLH2D20Cy78zps614MtRfrwxdK84Gbx1cg==
X-Received: by 2002:a19:7e42:: with SMTP id z63mr2178747lfc.36.1595506482172;
        Thu, 23 Jul 2020 05:14:42 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r19sm2654642ljm.32.2020.07.23.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:14:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jya7O-0006JN-5e; Thu, 23 Jul 2020 14:14:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] serial: add sparse context annotation
Date:   Thu, 23 Jul 2020 14:14:21 +0200
Message-Id: <20200723121423.24217-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Intel test robot reported a new sparse warning in pmac_zilog, which
wasn't actually new.

Add sparse annotation to the two drivers that release and reacquire the
port lock in their receive handlers to suppress these warnings.

Johan


Johan Hovold (2):
  serial: pmac_zilog: add sparse context annotation
  serial: msm_serial: add sparse context annotation

 drivers/tty/serial/msm_serial.c | 2 ++
 drivers/tty/serial/pmac_zilog.c | 1 +
 2 files changed, 3 insertions(+)

-- 
2.26.2

