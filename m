Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996ED2291DD
	for <lists+linux-serial@lfdr.de>; Wed, 22 Jul 2020 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgGVHOy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 22 Jul 2020 03:14:54 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:60384
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbgGVHOx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 03:14:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kw8MoTpkuVmfvPfYyLSHcVvm4qcwtz7sfWzQB+x0yW0cBt79oHuW0sDpfVCFRw40YLU8r3I3NlXZGY9yZKc9SN8TFpTvUYym/M7dd4e3kEjfiWZmvMuGMARXMM9Pokxl/Q6MdXQkSQmUsm0cvdlTgaAu3pkTHOnLKuc8USNL1Yj/BDAYEg0QHFlivjAJjn7lM+f3yQJG4GSveNw5M7RAT0jdEPbLoa3NtKi2R1AaVXgWPsvzxoqyTl81otTbe/D8hqTC/82pWw5ha7gilmizS5UmqlYpv5URcPcTzy7iCrKFgRjqo57xg03CSh4GME5EcuNJRqiyGEtjJZNi0WS6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3ASc5cMCxio41ABcHJVFJN0RscV/oFZc/sUQzoGW8Q=;
 b=LdW8AdiAsOdx+484mN7yBMlXUNKpgOzj222mk3an4ZABkqvIrNzJiGhd1eF9YWD3ImAXZQN2IZ0yg80207h65X4wc2jsh4GHXp+RxWAOYByaf2mPqJuC/hKVzs7znKrIyr5Q9A8hX2iMcExFwo4J3TV1E7PVbuCeW2caMCSxEoRA0IzFFY5ONAGgJoC25bogq2+wMgZJdDIrMeZ5IMey10k8QnFkWc8v2ZYpfCpUQh1Tx19Aa2eWQ+/1MkXs+CBpuAi6Z6DnARRra+HMnt2m0xurV2RutAR2D5KZMXjktWGeNGUzrKp//F+Lj9YdqCFOtdYSvzrHjPqIaOpCITG64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=intenta.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3ASc5cMCxio41ABcHJVFJN0RscV/oFZc/sUQzoGW8Q=;
 b=B/3CtdwLy3CAsEXah4KbZiVCIR/F79tcM5/s3ls1V4e3WahCaYcagIQQWktBHfF7/fKF+JHug+t8xOXPwTRoHAsvoKOLuiYWLCOPHSB6/dSoV60EwjAnAKwN8QCP2Ox4Y3Sf5P6cSLx8Z6tiX+I31Iup6NtqZCnMyiHmH5tgSak=
Received: from MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31)
 by BY5PR02MB6036.namprd02.prod.outlook.com (2603:10b6:a03:1b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 07:14:48 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23b:cafe::f7) by MN2PR11CA0026.outlook.office365.com
 (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend
 Transport; Wed, 22 Jul 2020 07:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; intenta.de; dkim=none (message not signed)
 header.d=none;intenta.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 07:14:46
 +0000
Received: from [149.199.38.66] (port=41797 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jy8vu-0002Oc-40; Wed, 22 Jul 2020 00:12:54 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jy8xi-0003Cq-8x; Wed, 22 Jul 2020 00:14:46 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06M7EhZ4019969;
        Wed, 22 Jul 2020 00:14:44 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jy8xf-0003C9-Cj; Wed, 22 Jul 2020 00:14:43 -0700
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
 <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
 <20200713071123.GA1994@laureti-dev>
 <e7b766ab-8c99-d30c-2352-6d7b09033537@xilinx.com>
 <20200713121019.GA6920@laureti-dev>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <7fea9efe-f439-33a3-966f-4215681ec4c8@xilinx.com>
Date:   Wed, 22 Jul 2020 09:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713121019.GA6920@laureti-dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(376002)(346002)(46966005)(5660300002)(316002)(54906003)(82310400002)(110136005)(36756003)(426003)(336012)(82740400003)(4326008)(47076004)(2616005)(31696002)(356005)(478600001)(186003)(81166007)(26005)(9786002)(70586007)(8936002)(31686004)(2906002)(44832011)(83380400001)(8676002)(70206006)(42866002)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87be65f5-66d8-4d86-cfb9-08d82e0eea32
X-MS-TrafficTypeDiagnostic: BY5PR02MB6036:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6036DC3E7EA52992FD13C965C6790@BY5PR02MB6036.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Htvs68xiLYW1fV8AKbKXJ6HkL5oQembupNznLAP9emUKvRxHgX77MO0pw+3yah4Ebp9ylMmg7mp6EA6Lv6lbzqWlLdIS84Y509reTYxTI3K/16NGE2uMR+oetUJWpvJJg2R7kfODSDos90N6iCidyEZUbt4Pu+dznQb5sGUf/6G4dgYmCx96zTKtEKKZETeUfZRNeAhjHHBlNWTN+yWjs5uhz2Jt4XDdtOqZxNMMjl+12DnotodmeSdY6VgFvzVeg9FNGHBmrsL0lWy3JH3YG+hkHE4MgFDL9TcsoMhjsM5x1zWKm9F8bYug1kVGan/Q5kJ7uxhbSWRp8r0KMOAX7kmaoajVXtjZMt6jCWqjIPXWzUvg6xhgupSYKIgs8UedgIuLA3NT/a2t3xH5mSW+wE4vL5IjZLZdo90ss+/S/yABGJV+aWP1Z/JHypsL2x/n+duHnTaBY28uKZaXY4k8og==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 07:14:46.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87be65f5-66d8-4d86-cfb9-08d82e0eea32
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6036
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 13. 07. 20 14:10, Helmut Grohne wrote:
> Hi Michal,
> 
> On Mon, Jul 13, 2020 at 01:49:38PM +0200, Michal Simek wrote:
>> On 13. 07. 20 9:11, Helmut Grohne wrote:
>>> Let me try to enumerate those I know:
>>>
>>> uart0    | uart1    | console | remark
>>> ---------+----------+---------+----------
>>> serial0  | serial1  | ttyPS0  | regular case
>>> serial0  | serial1  | ttyPS1  | normal assignment, second console
>>> serial1  | serial0  | ttyPS0  | -> Jan Kiszka, broken since revert
>>> disabled | serial0  | ttyPS0  | use only uart1 as serial0
>>> serial0  | disabled | ttyPS0  | regular case with uart1 disabled
>>>
>>> Out of these, I'm actively using configurations 3 and 4.
>>>
>>> Which of these scenarios do you test already?
>>
>> For above we are missing also others
>> serial1 | serial0 | ttyPS1
>> disabled| serial1 | ttyPS1
> 
> Is it actually possible to have ttyPS1, but no ttyPS0? I think I tried
> doing that earlier and it resulted in there being ttyPS0, but no ttyPS1.

serial1 alias should all the time create ttyPS1 device.
serial0 ttyPS0.

If there are no serial aliases driver should started numbering them from 0.


>> serial1 | disables | ttyPS0
> 
> I'm not sure what this is supposed to mean. When there is no serial0
> alias, I'd expect ttyPS0 to be missing. However as indicated above that
> is not what happens in practice. So either of these two configurations
> seems invalid to me.

You are right on this one - this is not possible. It should be ttyPS1.

> 
>> All of these above are just not setting any console= on bootargs.
> 
> We usually set the console= assignment on bootargs.

I found some time ago that setting up console in bootargs was covering
issue reported by Jan but didn't have time to look at it in more details.

> 
>> It means mix of these combinations is tested regularly but not all of
>> them. Do you see any other combination which is not supported?
> 
> I'm not aware of further relevant combinations.
> 
> Can we maybe trim down the matrix somehow? In my context, the need for
> swapping the serial aliases arises from a limitation in u-boot-xlnx and
> the desire to use one dtb for both linux and u-boot. It requires that
> the serial0 alias is the console. Are there other reasons to swap them?
> If not, maybe fixing u-boot would be an option?

I am not aware about any limitation in u-boot in this space. U-Boot is
working with aliases and also with stdout-patch selection.
Can you please elaborate more on this?

Thanks,
Michal
