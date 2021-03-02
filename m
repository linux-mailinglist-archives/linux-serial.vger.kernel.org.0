Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342B732B11F
	for <lists+linux-serial@lfdr.de>; Wed,  3 Mar 2021 04:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349120AbhCCCRa (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 2 Mar 2021 21:17:30 -0500
Received: from ciao.gmane.io ([116.202.254.214]:56698 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378383AbhCBPSf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 10:18:35 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-serial-6@m.gmane-mx.org>)
        id 1lH6LA-0004Go-MV
        for linux-serial@vger.kernel.org; Tue, 02 Mar 2021 15:49:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-serial@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: low_latency flag has gone missing
Date:   Tue, 2 Mar 2021 14:49:31 -0000 (UTC)
Message-ID: <s1lj9r$r0u$1@ciao.gmane.io>
User-Agent: slrn/1.0.3 (Linux)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some of the serial drivers that I maintain can make a tradeoff between
CPU usage, throughput, and rx data latency. For the past 20 years,
I've based that tradeoff on the tty struct's "low_latency" flag. This
allowed the user to choose between high-throughput with low CPU usage,
or higher CPU usage with lower latency and lower total throughput.

That low_latency flag appears to have "gone away" in v5.12.

How are users now supposed to indicate their desire for low-latency
operation for a serial port?

--
Grant


