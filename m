Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28917F318
	for <lists+linux-serial@lfdr.de>; Tue, 30 Apr 2019 11:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfD3Jfx (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 30 Apr 2019 05:35:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46024 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfD3Jfx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Apr 2019 05:35:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U9SOsE027785;
        Tue, 30 Apr 2019 09:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7NESZQ+VXjBNGWYCMQ5Ga1HxOlsu/81yUESa2dUGf00=;
 b=vRwXGEf5rRn3JidL57FxJv/6t+a07RKpQq7m6gZlM6Wtxdiko6knL/BfJwkginO0H7xe
 secE9HAQtVdS3W561w4i7KPFANrBpZKUsPC10gSjQcQ26oduhf5Y512UvfgJnz2gkF0L
 ukG+KuhxWgqMBOjGPSxPkKsCtIldCG4MEp1m4KPvHKmQls7iw0RrsQWbKV3BpjkXc3+U
 /NvYNbElEI2iDp2W8iN/jOlspE+mK2CwMeNxJwMyKtde8p6/XeYUp2RiIT63+XPf9u5d
 yagoubqPx1e5IQhslrSP0rOgPKNHfuQStsPutFsxUZfQrKbirGWTmFlwaMBavLT2jqI8 Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2s4fqq3bp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:35:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U9Zacb182678;
        Tue, 30 Apr 2019 09:35:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2s4yy9emwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:35:40 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3U9ZcMb031395;
        Tue, 30 Apr 2019 09:35:39 GMT
Received: from kadam (/196.97.65.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 02:35:38 -0700
Date:   Tue, 30 Apr 2019 12:35:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] serial: milbeaut_usio: Fix error handling in probe
 and remove
Message-ID: <20190430093526.GB2269@kadam>
References: <20190425151044.105045-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425151044.105045-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300063
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300063
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 25, 2019 at 03:10:44PM +0000, Wei Yongjun wrote:
> devm_clk_get() is used so there is no reason to explicitly call
> clk_put() in probe or remove functions.

Your patch is correct, but next time the patch description should be
more clear that this is a double free.  To me the patch description
sounded like it was just tidying up or something instead of fixing a
crash.  It might feel rude to say that the original code will crash, but
we are all human so introducing crashing bugs is not something to be
embarrassed about.

regards,
dan carpenter

