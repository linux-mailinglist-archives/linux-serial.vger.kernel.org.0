Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A024B711
	for <lists+linux-serial@lfdr.de>; Thu, 20 Aug 2020 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgHTKq4 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 Aug 2020 06:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731876AbgHTKoT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Aug 2020 06:44:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33900C061385
        for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2020 03:44:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so951230pgf.0
        for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2020 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PXtPhgN15xkqptqDoOT+6OR5bz1DwLunRYJNev9KR4=;
        b=zkaFZto0eMoTUXrhXnN5c215rPk2SI+mYKS6axiQrRCTTNkAxc+HQ1zvbE+9q8CdK3
         ejrwiC5XvbU1VEVR0PkGPGG669EkRUf07na+UAjM95hQEAsG4rAcauD7W4QS/mQQK9Ji
         aHAzBEJD8cb3YAopp2IN0BnKR0TfeOemTuipy2eA7MsVI9rqpSpfngZuJ3YGffGgvoOr
         2qaNwaJ3BQvjLM/eOrXzy4yluttDslK9WrVaLBIAQGyCyGmcBfTPfVT8FfIY5a1ueI/3
         qAMmm3cwSJncp0MSZc3c4f5Ucf1L5617fzuL31JE1OimTfSyQCLy69f4jWzzKMfRVtbY
         sboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PXtPhgN15xkqptqDoOT+6OR5bz1DwLunRYJNev9KR4=;
        b=GQlM+Psr73+3/2c2yknPLdrK1WsouYrtFwv4oRhYFTxnZ/UVlhMYw4KgfjJKL0WqAt
         jqZTNjoGEJVcEqgNBqe2ZBILbeRbzUIgCqpzR+ksRj5eJetxVydxx1Cyg9oePwqYkSuV
         VjVuBmBMXAvmb9Koqd1bAPbmjUgEhvk1yPiISsIfU5pzmDou+EZey+djQMyKS1GfZQFX
         INsl2woO0jmIlYIwaAxV8Gywqt4ToUAK1IGvPNbfc84s7mnI8X70y/UGfpHK7EYnqdz3
         rJUrDg5HCSWDtS8jApDNFzjyFNr9CtbSea06dlWRG0ZmBwtdxw7J0eRD1fTwHsuiio5n
         b2wA==
X-Gm-Message-State: AOAM5337+znihfmUxrRfp3mQl9sVJ3wqJ+uN1BqyhIylsn1PQ6mMO5Le
        s2oRugb/HMXNIwZ+6n/F6/9dig==
X-Google-Smtp-Source: ABdhPJzGI4PMt2rxPglqL7BKdt2SWVVgHiE/GuL96GZfgXci06o5FRoVl3y2qYxeBmL8p5wYvmHOSw==
X-Received: by 2002:a65:4808:: with SMTP id h8mr2045357pgs.113.1597920255960;
        Thu, 20 Aug 2020 03:44:15 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id e8sm2352323pfd.34.2020.08.20.03.44.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Qiang Yu <yuq825@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sean Paul <sean@poorly.run>, Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 0/8] opp: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Thu, 20 Aug 2020 16:13:49 +0530
Message-Id: <cover.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

This cleans up some of the user code around calls to
dev_pm_opp_of_remove_table().

All the patches can be picked by respective maintainers directly except
for the last patch, which needs the previous two to get merged first.

These are based for 5.9-rc1.

Rajendra, Since most of these changes are related to qcom stuff, it
would be great if you can give them a try. I wasn't able to test them
due to lack of hardware.

Viresh Kumar (8):
  cpufreq: imx6q: Unconditionally call dev_pm_opp_of_remove_table()
  drm/lima: Unconditionally call dev_pm_opp_of_remove_table()
  drm/msm: Unconditionally call dev_pm_opp_of_remove_table()
  mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
  spi: spi-geni-qcom: Unconditionally call dev_pm_opp_of_remove_table()
  spi: spi-qcom-qspi: Unconditionally call dev_pm_opp_of_remove_table()
  tty: serial: qcom_geni_serial: Unconditionally call
    dev_pm_opp_of_remove_table()
  qcom-geni-se: remove has_opp_table

 drivers/cpufreq/imx6q-cpufreq.c         | 10 ++--------
 drivers/gpu/drm/lima/lima_devfreq.c     |  6 +-----
 drivers/gpu/drm/lima/lima_devfreq.h     |  1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 10 +++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  1 -
 drivers/gpu/drm/msm/dsi/dsi_host.c      |  8 ++------
 drivers/mmc/host/sdhci-msm.c            | 11 +++--------
 drivers/spi/spi-geni-qcom.c             | 10 +++-------
 drivers/spi/spi-qcom-qspi.c             | 11 +++--------
 drivers/tty/serial/qcom_geni_serial.c   | 10 +++-------
 include/linux/qcom-geni-se.h            |  2 --
 11 files changed, 20 insertions(+), 60 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

