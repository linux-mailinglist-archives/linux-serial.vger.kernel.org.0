Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE554C77
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfFYKkX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Tue, 25 Jun 2019 06:40:23 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.112]:52444 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726756AbfFYKkW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jun 2019 06:40:22 -0400
Received: from [67.219.247.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-d.us-east-1.aws.symcld.net id 1A/02-13972-41AF11D5; Tue, 25 Jun 2019 10:40:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRWlGSWpSXmKPExsXi5LtOQFfkl2C
  swbnD6hbNi9ezWTw84GxxZnEvu8Wf/Q+ZLDZvmspscX79bhaLHxseszqwe2xa1cnm8e7cOXaP
  /XPXsHs8m36YyePzJrkA1ijWzLyk/IoE1oznL54xFzxiq9hyeQ5rA+NW1i5GLg4hgdWMEgcvL
  2eHcPYySnw9+Zaxi5GTg03AUGL1giPsILaIgIbExku3mEGKmAW6mSRWNG0GSwgLGEhsO/sPyO
  YAKjKUWPmTC8Ksk/je5Q1SwSKgKrHl5FmwkbwC1hJT3s5iArGFBN6zSpzdrw5icwp4SUyZ9xl
  sIqOArMSL9glgNcwC4hK3nswHsyUEBCSW7DnPDGGLSrx8/I8VZJWoQLjE9SuFEGEFiU+7/7BA
  tOpJPDs1C8o2lzjW+AbK1pZYtvA1M8Q5ghInZz5hgThHRWLblG62CYzis5BsnoVk1Cwko2YhG
  TULyagFjKyrGE2TijLTM0pyEzNzdA0NDHQNDY10LYGkXmKVbopeabFuamJxiS6QW16sV1yZm5
  yTopeXWrKJERjvKQWc3DsYpx15rXeIUZKDSUmU16hDMFaILyk/pTIjsTgjvqg0J7X4EKMMB4e
  SBK/UT6CcYFFqempFWmYOMPXApCU4eJREeItA0rzFBYm5xZnpEKlTjLocE17OXcQsxJKXn5cq
  Jc5b9QOoSACkKKM0D24ELA1eYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMGwWyiiczrwRu0
  yugI5iAjtg8gQ/kiJJEhJRUA1NVwqyelpBLb5s2P7+wNyRqw881OhUxrYtWcXCFfnpxws21M3
  V/w18zm63K6avmvOposzi890fk7Eqtq+2C09aHffVav2Btws64JevPfKjYPbWzYoXeVibdmzY
  nHS3erff+1flt8Sv5mmmhHLPm/Mr/5v9Y1t13yyJzjVqF+WU9T/M99uRY+B564vbke9vJlVIi
  S1Y5dGp9WXgy8biU6qfAPs831lV3w8+kxmhaztOy37Vg/al9/E9t7xS0vy4U8X8VGz11U8dG4
  ymrj/QzzMp/qvNR8tXddQwl/FK/JDeE3puknPAzWDLi1pN3qw9vUlr2zVfWMfjiqq3W4kFZb7
  JW7N/q+OZVkiL/A45mHrGtSizFGYmGWsxFxYkAzATEE/4DAAA=
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-19.tower-425.messagelabs.com!1561459220!2325971!2
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24141 invoked from network); 25 Jun 2019 10:40:20 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-19.tower-425.messagelabs.com with SMTP; 25 Jun 2019 10:40:20 -0000
Received: from MTK-SMS-XCH03.digi.com (10.10.8.197) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 05:40:20 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH03.digi.com ([fe80::484d:c326:e7f1:a9fd%16]) with mapi id
 14.03.0439.000; Tue, 25 Jun 2019 05:40:19 -0500
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Michael Shych <michaelsh@mellanox.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: "No irq handler for vector" problem
Thread-Topic: "No irq handler for vector" problem
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamqPoA//+5LYeAAzhHgIAASXUAgAEJGYCAAC41AIAAFYCAgABOuACAAEL3AIAAt3SAgAAIm4CAAAWxgA==
Date:   Tue, 25 Jun 2019 10:40:17 +0000
Message-ID: <c7a830df-56ff-e03d-7634-7a6f1e45f9d9@digi.com>
References: <dcc1febb-2afc-da9b-696e-3c9bf63f4b76@digi.com>
 <alpine.DEB.2.21.1906211858340.5503@nanos.tec.linutronix.de>
 <37433D8393E7AF43B0D856B93884DA9E4FD67B64@MTK-SMS-XCH02.digi.com>
 <AM6PR05MB61689A1EE1E6B31682A476FAD9E10@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <alpine.DEB.2.21.1906231955420.32342@nanos.tec.linutronix.de>
 <AM6PR05MB6168265CCF44FBCAEBBD4EA8D9E00@AM6PR05MB6168.eurprd05.prod.outlook.com>
 <d40acbee-df87-1f4b-48c1-66fe31c841fd@digi.com>
 <alpine.DEB.2.21.1906241609080.32342@nanos.tec.linutronix.de>
 <c49e9454-d6d2-408c-8232-ee4c17d6975d@digi.com>
 <alpine.DEB.2.21.1906242335250.32342@nanos.tec.linutronix.de>
 <a1582e82-c2b3-95fd-0c92-e04765da0a59@digi.com>
 <alpine.DEB.2.21.1906251213021.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906251213021.32342@nanos.tec.linutronix.de>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [172.27.2.174]
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <65EF5A0422749C42A121F1F2FD6FCF2B@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 25 Jun 2019, Gleixner, Thomas wrote:

>
> The thing is that the interrupt is in edge mode which my tried brain did
> not notice yesterday evening.
>
> In edge mode the remote-irr bit meaning is undefined and as the docs are
> unclear it might eventually give the wrong answer. From a hardware view
> this makes sense because edge will just fire and forget, while level needs
> the explicit ack before sending it again (if still raised at the pin)
>
> So for edge the issue is different. The spurious interrupt is harmless as
> it does not leave stale state in the IO-APIC around.
>
> I'm working on a clean fix for both the level and the edge problems. Just
> at the point to start testing. Will post the result in a couple of hours.
>
> Thanks,
>
> 	tglx
>
>
Hmm, good point. Checking the IO-APIC datasheet again, it's clearly written.

Thanks,

Robert
