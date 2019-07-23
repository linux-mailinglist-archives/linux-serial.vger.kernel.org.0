Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8867F70F89
	for <lists+linux-serial@lfdr.de>; Tue, 23 Jul 2019 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfGWDI3 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 22 Jul 2019 23:08:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43317 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbfGWDI3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jul 2019 23:08:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so18348801pfg.10
        for <linux-serial@vger.kernel.org>; Mon, 22 Jul 2019 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YVNcqC153E1MBeLRE/tHmxAAaoAZPb0wARTQIeDeZgo=;
        b=NSB2zBfYzU4jALW9m3TD95osVT68HM2LONRNLLxaV+aeH9W85+HZN8koN7wbszxlSV
         vjUWDksJ8MeGNUyl4Hhmdry4Js3TxcFKYZjKkRfn/KRzM8TSmYxB7FflIGiyevIbZ6e4
         49ruB2imCqby/x3nY20w4oNnHl/GkW5ZU+s5ipe9uZsM96lT56OVQh8G7dz1FRojNAcS
         aIO1m4JanaIvVlv+GVIPZGWWd6eEzw9Etjf6wbPsX+gUYnjuTvLRHX4Crmq+s1yNn76N
         l77yjqfB4og/ymNqATL1hvXpcOKm+jWt6RgNz72QqWl5ny97t0+wPgzFGwy2pC6FCCfz
         uqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YVNcqC153E1MBeLRE/tHmxAAaoAZPb0wARTQIeDeZgo=;
        b=JNPvWlZbQC/HrLG4IFswLsrtZ5oQINMkAMr1NRQYvNhlUauNa7f/HKBRKmDyi07lK9
         DPGmAJBNeTFrmWpH7/FSLNzTjTQChKuGEZpHfX4gu2Y5ExljIK42awFVKLtv63AZxlcN
         x0VPd+xz2vtylOR6p52t8WPAdx5uJJDhdHtkTscsJ8+DGzU/spdpCYtm46lbKehTW/44
         ITiEGE1iXuQNl64Zpz3LRqCb9bKLHkEVNdNbX640Ne8BYz5t6lrojvSPOCyDzSkIKXfi
         O1HqkppeMuzyAbKbH/4eicMecLl16RSq7PbzlxeWNKh2RN7K4a6MkOmcF5FCCSdrcFjT
         9omg==
X-Gm-Message-State: APjAAAXTXLBHAJdSp/aLn8EfiNprFHFSoNc7McaVgwBhUYZOnCaqXtzm
        2BPlZN+iDizN8t0lN+4i+gw=
X-Google-Smtp-Source: APXvYqzHN97O5SULNOgIsRTU7+dSeDhFCV5u7vCXD4N1HXvjOn+TLufSGNV3Ukpk8k9rzdIg2gaLVA==
X-Received: by 2002:a62:e315:: with SMTP id g21mr3585927pfh.225.1563851308764;
        Mon, 22 Jul 2019 20:08:28 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-237-209.dynamic-ip.hinet.net. [114.36.237.209])
        by smtp.gmail.com with ESMTPSA id g4sm52886977pfo.93.2019.07.22.20.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:08:28 -0700 (PDT)
From:   morrisku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kai.heng.feng@canonical.com, tiffany.wang@canonical.com,
        morris_ku@sunix.com, linux-serial@vger.kernel.org,
        morrisku <saumah@gmail.com>
Subject: Re: [PATCH] Add driver for SUNIX Serial board.
Date:   Tue, 23 Jul 2019 11:08:13 +0800
Message-Id: <20190723030813.4728-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

>On Fri, Jul 19, 2019 at 06:10:50PM +0800, morrisku wrote:
>> Add Kconfig and Makefile entry.
>> 
>> Signed-off-by: Morris Ku <saumah@gmail.com>
>> ---
>>  serial/Kconfig  | 11 +++++++++++
>>  serial/Makefile |  2 +-
>>  2 files changed, 12 insertions(+), 1 deletion(-)

>Same report as the 1/2 patch, and your subject is wrong here :(

I will modify subject line to [PATCH 2/2] tty/serial: Add driver for SUNIX serial board.
or [PATCH 2/2] tty:serial: Add driver for SUNIX serial board.

Is that OK?

This driver patch separate into 2 patches : 
Do i need to modify subject line to [PATCH 1/2] and [PATCH 2/2] ?

