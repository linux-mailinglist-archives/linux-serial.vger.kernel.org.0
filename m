Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B388ABDA
	for <lists+linux-serial@lfdr.de>; Tue, 13 Aug 2019 02:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfHMAOd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 12 Aug 2019 20:14:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37919 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHMAOc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Aug 2019 20:14:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so99899109ljg.5
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2019 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=VZPiwW9mQpjfyb0bK/U+vbA36fSfXE95Zq0lecUQxuQ=;
        b=Nqxnu8pajWwpItmbKjK4yxP92y7unlCkUTLjcmyKDvufZjl7eZ/f+y0BwTZJFED5KF
         XiFjVYT/SyyIfgRAqFUDggZ28BQUgYi9j+Afy8QhZrWD6Nno7qJQRxUvSHQYHnJ17agC
         f3WRkEqunWVR51lhBbkRQWkKNIbYIr3DKhtFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VZPiwW9mQpjfyb0bK/U+vbA36fSfXE95Zq0lecUQxuQ=;
        b=etaXSDmSwWlFIUCvazX20qxB2bZQ1YQYuGFHgOiWm9RYdXMhZ1wpXAKQhqwyxcwaX9
         QtVi1Y5agKE6lxhrFRPgT1u+eJr0kqdY+0sbOVfpkYA5Jvh5AKv03DxnoJjNUH+49YyB
         Ap6MtsdOxJXEJYKOT8ncgADC0ir7b7q0NDrvcozhpY99l/fZIKr32cpff4VJ5VIpkHVO
         fK1RbHyV/6CuBy0Lt9G8TwjPDSwZDdsF/vG9pJGNLGXgJtAXcDWAhiBQxgP0uO2VmhkR
         0u8okSva9JPHPnl/nEoHJiSpY+k/CnfwbePX476dRTnQTjCZ+V4N5m5FwNAbmIENtarx
         Uh7A==
X-Gm-Message-State: APjAAAVsh7c1ozZo83bnNCBsd+QaJ6hTw4CD8WLUyfH4IOeDY1XucGuA
        FCN9GgToTQe2mOc2xNmi2G8CiblcpwuVqRA6sCnh2Q6YTqBMsQ==
X-Google-Smtp-Source: APXvYqz6jAcOH6jmWnG3fF0hhfN6lhRfW9tzKBM1QXyHd7e1HkPQRavXoZtSmO1ftEshN1t6P15tf56orcxmGKZKsNA=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr20312821ljc.123.1565655270589;
 Mon, 12 Aug 2019 17:14:30 -0700 (PDT)
MIME-Version: 1.0
From:   Suji Velupillai <suji.velupillai@broadcom.com>
Date:   Mon, 12 Aug 2019 17:14:19 -0700
Message-ID: <CAJHBTCAiUoRwXq=ZNKfSKbdoAXCe8KSiqcL3iv510jseB8s6mA@mail.gmail.com>
Subject: Serial to shared memory
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

We have client which is running Linux and it is connected to host over
PCIe. Both shares PCIe bar space as shared memory. Currently we only
have one UART for debug, but this can't be used by the client, thus we
need a virtual serial console running on a client side, which can
read/write from PCIe mapped shared memory. The host can open the tty
port seamlessly for communication.

I looked into the kernel tty/serial/ tree, and did not find any sample
one. Is there a sample code?
Do you have any suggestions on implementation that would be acceptable
into mainline?

Appreciate your help

Thank you
Suji
