Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2E367D0E
	for <lists+linux-serial@lfdr.de>; Thu, 22 Apr 2021 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhDVJAQ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 22 Apr 2021 05:00:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16489 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbhDVJAQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 05:00:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQrs91QNnzrgC8;
        Thu, 22 Apr 2021 16:57:17 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 22 Apr 2021 16:59:29 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/3] dt-bindings: serial: pl011: Fix some dtbs_check warnings
Date:   Thu, 22 Apr 2021 16:58:34 +0800
Message-ID: <20210422085837.513-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

v1 --> v2:
1) Change to reference the kernel-defined serial.yaml
2) Move the new added "label: true" into /schemas/serial/serial.yaml

Zhen Lei (3):
  dt-bindings: serial: Normalize the node name of the serial port
  dt-bindings: serial: pl011: Change to reference the kernel-defined
    serial.yaml
  dt-bindings: serial: Add label property in serial.yaml

 Documentation/devicetree/bindings/serial/pl011.yaml  | 4 ++--
 Documentation/devicetree/bindings/serial/serial.yaml | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.21.1


