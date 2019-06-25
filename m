Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B09550AF
	for <lists+linux-serial@lfdr.de>; Tue, 25 Jun 2019 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfFYNqI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-serial@lfdr.de>); Tue, 25 Jun 2019 09:46:08 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.118]:47893 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbfFYNqI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jun 2019 09:46:08 -0400
Received: from [67.219.246.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-7.bemta.az-c.us-east-1.aws.symcld.net id 94/B4-10343-E95221D5; Tue, 25 Jun 2019 13:46:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRWlGSWpSXmKPExsXi5LtOQHeuqlC
  swdV2E4vmxevZLB4ecLY4s7iX3eLP/odMFps3TWW2OL9+N4vFjw2PWR3YPTat6mTzeHfuHLvH
  /rlr2D2eTT/M5PF5k1wAaxRrZl5SfkUCa8aDZX+YC3pZKtrPPGdsYFzE3MXIySEksJpRYlpXR
  hcjF5C9l1GicWIrE0iCTcBQYvWCI+wgtoiAhsTGS7eYQYqYBbqZJFY0bQZLCAsYSGw7+w/I5g
  AqMpRY+ZMLpEZEoIlRom/eYVaQGhYBVYkLf46BDeUVsJY4smc1K8S2BWwSRzc8ZQFJcArYSJy
  /eJYNxGYUkJV40T4BrIFZQFzi1pP5YLaEgIDEkj3nmSFsUYmXj/+xgiwWFQiXuH6lECKsIPFp
  9x8WiFY9iWenZkHZ5hLLDl6DsrUlli18zQxxj6DEyZlPWCAhoSKxbUo32wRG8VlINs9CMmoWk
  lGzkIyahWTUAkbWVYxmSUWZ6RkluYmZObqGBga6hoZGuuZAlrleYpVusl5psW5qYnGJrqFeYn
  mxXnFlbnJOil5easkmRmDUpxSwZ+9g/Hzktd4hRkkOJiVRXqMOwVghvqT8lMqMxOKM+KLSnNT
  iQ4wyHBxKErxGKkKxQoJFqempFWmZOcAEBJOW4OBREuENA0nzFhck5hZnpkOkTjHqckx4OXcR
  sxBLXn5eqpQ47xWQIgGQoozSPLgRsGR4iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw7yVlo
  Ck8mXklcJteAR3BBHTE5gl8IEeUJCKkpBqYMiOWme+XOZtYdCdn+rKXDhkMhfeYH8uutV12Yd
  ajhPcX6+9vbhJpeSNn1bzgol783RuvC1SymWuTY44yXBKz1b59WGvS3U05y71LNG1Lt4vnn73
  mdl52Wuhzn946s181640cb69pYD2UvPFU5a5WmScCmdX6nHfOVT1bub3k8CR2F51/IZ2JPbof
  V12Kvn72c+uRw1wpQe9yPlztOX70wCXukEMedc8nCV5a88OTL8p535IDU7+8/9N/m435R8KdN
  /0f/2s6r9m/7ZvQtRvZJv8La8OdOmTe3G+doHWHK/B7V60p08Y/x293783ncAu6M++7hnOw7q
  ZVsh5zbfysjkq5nnzYwDHjX75U3uEfd5RYijMSDbWYi4oTAYxmKhwBBAAA
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-17.tower-405.messagelabs.com!1561470365!234832!2
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32427 invoked from network); 25 Jun 2019 13:46:05 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-17.tower-405.messagelabs.com with SMTP; 25 Jun 2019 13:46:05 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 08:46:05 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH04.digi.com ([fe80::ed97:4834:fa1b:3be7%19]) with mapi id
 14.03.0439.000; Tue, 25 Jun 2019 08:46:05 -0500
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
Thread-Index: AQHVKDldOPMq6dwWv0y/P7fHdq3NuKamqPoA//+5LYeAAzhHgIAASXUAgAEJGYCAAC41AIAAFYCAgABOuACAAEL3AIAAt3SAgAAIm4CAAAWxgIAAM+eA
Date:   Tue, 25 Jun 2019 13:46:03 +0000
Message-ID: <e1eda070-6326-ac1f-803f-917e0e1c1ee6@digi.com>
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
 <c7a830df-56ff-e03d-7634-7a6f1e45f9d9@digi.com>
In-Reply-To: <c7a830df-56ff-e03d-7634-7a6f1e45f9d9@digi.com>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [172.27.2.174]
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <A12C5F9BC873154AB657D84A977EE7CC@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 25 Jun 2019, Gleixner, Thomas wrote:

I'm working on a clean fix for both the level and the edge problems. Just
at the point to start testing. Will post the result in a couple of hours.

Thanks,

    tglx




I checked the patch. That will obviously fix the "error message appearing" problem. :) I assume, no need to test that, but just in case, I applied all patches, and error message is gone. Which is probably more useful feedback: interrupts, and everything seems working fine on my side.

Thanks!

Robert
