Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BFA38AD2B
	for <lists+linux-serial@lfdr.de>; Thu, 20 May 2021 13:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbhETL5v (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 20 May 2021 07:57:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3625 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhETL4H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 07:56:07 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fm7QM4SmrzmWcC;
        Thu, 20 May 2021 19:52:27 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 19:54:44 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 19:54:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/2] dt-bindings: serial: pl011: Avoid matching device tree nodes of variant pl011 drivers
Date:   Thu, 20 May 2021 19:54:38 +0800
Message-ID: <20210520115440.8259-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Zhen Lei (2):
  dt-bindings: serial: pl011: Delete an incorrect compatible string
  dt-bindings: serial: pl011: Avoid matching device tree nodes of
    variant pl011 drivers

 .../devicetree/bindings/serial/pl011.yaml         | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.21.1


