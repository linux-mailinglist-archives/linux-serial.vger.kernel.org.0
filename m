Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04C58E38
	for <lists+linux-serial@lfdr.de>; Fri, 28 Jun 2019 01:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfF0XAZ (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 27 Jun 2019 19:00:25 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:3693 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbfF0XAZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jun 2019 19:00:25 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 19:00:24 EDT
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6BA5C8C2A7B
        for <linux-serial@vger.kernel.org>; Thu, 27 Jun 2019 22:54:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a29.g.dreamhost.com (100-96-85-75.trex.outbound.svc.cluster.local [100.96.85.75])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DB9D08C2C4B
        for <linux-serial@vger.kernel.org>; Thu, 27 Jun 2019 22:54:52 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a29.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Thu, 27 Jun 2019 22:54:53 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Plucky: 23c7d22b70da8e17_1561676093260_840197411
X-MC-Loop-Signature: 1561676093260:1358747009
X-MC-Ingress-Time: 1561676093260
Received: from pdx1-sub0-mail-a29.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a29.g.dreamhost.com (Postfix) with ESMTP id 0053583032
        for <linux-serial@vger.kernel.org>; Thu, 27 Jun 2019 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :from:date:message-id:subject:to:content-type; s=rm5248.com; bh=
        iQp0m7k18LP5pvZFWqRJY3AOo2c=; b=mNATgSqH2GPLSgqCNKql6hZamPsXscnU
        A6+gbdIOnyXBJQ2YAYfT49uuMCt39+o+sXYShka/rrX2LqW/H6EX7DLz2nnLhw9U
        oZv3sDgkHug1r46FuQhgnmjxOtoZxWiQ7vepP8ttTFbsX2klG1595RtghLq7boGP
        KqD6cGaV62o=
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a29.g.dreamhost.com (Postfix) with ESMTPSA id A27D183026
        for <linux-serial@vger.kernel.org>; Thu, 27 Jun 2019 15:54:51 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id j6so8446173ioa.5
        for <linux-serial@vger.kernel.org>; Thu, 27 Jun 2019 15:54:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXYyiFiSX9o5C2iTK2AlXisFnZjpnES8uZxIgcyFR/2otL8C74Y
        Sni78E1az1UL3Fe6l4vLH7RmhY134362xyUrgnk=
X-Google-Smtp-Source: APXvYqwGQZrHAO8RNo9BmK7T/dcJQ96yp5nzoY4wZbHtj+k4iaqWqHVBj0SFhPf9KNSwpd/FxIA7XKpF4/QLosD6Wog=
X-Received: by 2002:a02:5b05:: with SMTP id g5mr7394643jab.114.1561676090934;
 Thu, 27 Jun 2019 15:54:50 -0700 (PDT)
MIME-Version: 1.0
X-DH-BACKEND: pdx1-sub0-mail-a29
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Thu, 27 Jun 2019 18:54:39 -0400
X-Gmail-Original-Message-ID: <CAKpcJVav5-_VdakmPYatZ5iZa38=_wN-gd4yhsx0Pfo+zR+2-Q@mail.gmail.com>
Message-ID: <CAKpcJVav5-_VdakmPYatZ5iZa38=_wN-gd4yhsx0Pfo+zR+2-Q@mail.gmail.com>
Subject: Issue with XR17V35X
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudelgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepggfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrudeiiedrhedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqihhouddqfhehvddrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrdduieeirdehvddprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all,

I've encountered a problem with the driver for the XR17V358
PCIe-to-serial converter.  When I try to send data to the chip, it is
only transmitted properly if I am also reading from the tty at the
same point.  That is the following sequence in the terminal works:

cat /dev/ttyS13 &
echo "this is a test" > /dev/ttyS13

The data "this is a test" will be sent correctly out the serial port.
However, if I don't cat it and do just the following:

echo "this is a test" > /dev/ttyS13

then I will occasionally get the first character('t'), occasionally
nothing, but never the entire message and never more than one byte.

I tried to track this down earlier today, but I haven't been able to
figure out where exactly it is going wrong.  Has anybody else seen
this?  Does anybody know what exactly to look for to fix this?  I was
poking around alot in 8250_port.c, since that seems to be where most
of this is happening, but I wasn't sure if this is an exar-specific
thing or if it is a problem with all 16550-compatible UARTs.

-Robert Middleton
