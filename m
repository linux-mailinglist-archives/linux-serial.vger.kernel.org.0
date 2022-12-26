Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D89656452
	for <lists+linux-serial@lfdr.de>; Mon, 26 Dec 2022 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLZRRk (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 26 Dec 2022 12:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLZRRj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Dec 2022 12:17:39 -0500
Received: from mail.someserver.de (mail2.someserver.de [IPv6:2001:4d88:3503:c001:56b7:8a99:4a7f:4e4b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA302BC3
        for <linux-serial@vger.kernel.org>; Mon, 26 Dec 2022 09:17:36 -0800 (PST)
Received: from localhost (unknown [46.128.84.4])
        by mail.someserver.de (Postfix) with ESMTPSA id 3022D8014D;
        Mon, 26 Dec 2022 18:17:33 +0100 (CET)
From:   Christina Quast <contact@christina-quast.de>
To:     linux-serial@vger.kernel.org
Cc:     Christina Quast <contact@christina-quast.de>,
        ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
        daniel.beer@igorinstitute.com
Subject: [PATCH tty-next v2 0/3] hid-ft260 cleanups
Date:   Mon, 26 Dec 2022 18:15:46 +0100
Message-Id: <20221226171549.73645-1-contact@christina-quast.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Cleanups in preparation for the serial driver functionality addition
to hid-ft260. Those cleanups include adding braces into macros,
renaming the ft260_i2c_input_report structure and datatype changes
in hw facing structs.

Changelog:
Added Changelog to each of the patch files.

Christina Quast (3):
  hid-ft260: Cleanup macro formatting
  hid-ft260: Rename struct ft260_i2c_input_report
  hid-ft260: Change u8 to __u8 for hw facing structs

 drivers/hid/hid-ft260.c | 100 ++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

-- 
2.35.1

