Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8A84DD8
	for <lists+linux-serial@lfdr.de>; Wed,  7 Aug 2019 15:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbfHGNsi (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 7 Aug 2019 09:48:38 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:3752 "EHLO
        egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388200AbfHGNsi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Aug 2019 09:48:38 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 47D0950020A
        for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2019 13:48:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a2.g.dreamhost.com (100-96-6-233.trex.outbound.svc.cluster.local [100.96.6.233])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B8C6250051A
        for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2019 13:48:24 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a2.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Wed, 07 Aug 2019 13:48:25 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Share-Descriptive: 3f21a95911e6eca6_1565185705052_617402346
X-MC-Loop-Signature: 1565185705051:3129721833
X-MC-Ingress-Time: 1565185705051
Received: from pdx1-sub0-mail-a2.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a2.g.dreamhost.com (Postfix) with ESMTP id 32A6E839C5
        for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2019 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=VjUuFdlTqdwwdg6Pe7I+jkZr98s=; b=
        X0Fp98OQEHcC4GYRSx7a0yk85I6aFs5UiN6dUvGGphfT7K77btbrIIMNWmbhROHl
        ge0UvtmswyaoZzxEUU97zm+/nGIK9S3kI3Yg1vhCBcF/iyAigWXI5LBbgXIjIXCT
        4ybBSKCe03wzVcGUUMqio23CdL2UMg7DdmV04/PMRl8=
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a2.g.dreamhost.com (Postfix) with ESMTPSA id D7440839C3
        for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2019 06:48:15 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id l15so104492665otn.9
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2019 06:48:15 -0700 (PDT)
X-Gm-Message-State: APjAAAXmdWys95nTGexFm38rB+pRP/YnRGmuXQhzwai69I0MN3KC5td1
        VMMEHAH5XquxM03R9thWI0BIjOYIB9iUqGE7bW8=
X-Google-Smtp-Source: APXvYqwzjbLVUpoGY/HYOMxnNDWt2v7TVFwX4Vo267qc3cFXhEZs6ip2Wg739LdfPEnW8y3MSuv+e/8JoYSF2upTBwc=
X-Received: by 2002:a02:90c8:: with SMTP id c8mr10309950jag.22.1565185694991;
 Wed, 07 Aug 2019 06:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190805100518.9818-1-andriy.shevchenko@linux.intel.com>
 <20190805100518.9818-2-andriy.shevchenko@linux.intel.com> <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com> <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com> <20190806153110.GG30120@smile.fi.intel.com>
 <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
In-Reply-To: <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
X-DH-BACKEND: pdx1-sub0-mail-a2
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Wed, 7 Aug 2019 09:48:03 -0400
X-Gmail-Original-Message-ID: <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
Message-ID: <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudduvddgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrvddutddrgeegnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqohhtuddqfheggedrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrddvuddtrdeggedprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> I'll try to get some firm results in the morning; otherwise I won't be
> able to check until early next week as I will be away from the
> hardware.

After doing more testing, I think that I finally have something that
is working fully at all baud rates.  I've tested this at
115200,9600,and 4800, testing via: echo "the quick brown fox jumps
over the lazy dog" > /dev/ttySx

Removing the check to uart_circ_empty in the while loop makes it more
reliable, however it will occasionally fail and only transmit the
first part of the message(at 4800, it will transmit only "t", at
115200 it will transmit "the quick bro").  I've found that breaking it
into two loops, one checking the uart_circ_empty and the other doing
the LSR check is reliable at all baud rates.  Here's what I have at
the moment:

diff --git a/drivers/tty/serial/8250/8250_exar.c
b/drivers/tty/serial/8250/8250_exar.c
index e7448831af6d..4e415b915e35 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -565,18 +565,21 @@ static void
 exar_shutdown(struct uart_port *port)
 {
     unsigned char lsr;
-    bool tx_complete = 0;
     struct uart_8250_port *up = up_to_u8250p(port);
+    unsigned int times = 1000;
     struct circ_buf *xmit = &port->state->xmit;

+    while (!uart_circ_empty(xmit) && --times > 0) {
+        usleep_range(1000, 1100);
+    }
+
+    times = 1000;
     do{
         lsr = serial_in(up, UART_LSR);
         if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
-            tx_complete = 1;
-        else
-            tx_complete = 0;
-        msleep(1);
-    }while( !uart_circ_empty(xmit) && !tx_complete );
+            break;
+        usleep_range(1000, 1100);
+    }while( --times > 0 );

     serial8250_do_shutdown(port);
 }

I can do a formal patch later, but I just wanted to see if this made
sense first.  The second loop is now much simpler, and does not do the
buffer check at the same time, which was probably causing some
problems with the previous version.

-Robert Middleton
