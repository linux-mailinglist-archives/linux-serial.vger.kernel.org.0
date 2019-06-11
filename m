Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491963D4ED
	for <lists+linux-serial@lfdr.de>; Tue, 11 Jun 2019 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406736AbfFKSEK (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 11 Jun 2019 14:04:10 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406724AbfFKSEK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jun 2019 14:04:10 -0400
Received: from [192.168.1.110] ([95.118.191.213]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSKq0-1h838b1yQq-00Sce9 for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2019
 20:04:09 +0200
To:     linux-serial@vger.kernel.org
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: RFC: can we get rid of ->request_port() boilerplate ?
Organization: metux IT consult
Message-ID: <999dbc29-8254-7168-1fa0-7caf03bb6d77@metux.net>
Date:   Tue, 11 Jun 2019 20:04:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DGYQ/R9Z0uzqTZQY1pZ3gx9t6gU5lr4TGTn3ERwpoAv0yc7yb/H
 Sazk1jNOv4c04jQ6eWQAJcnMMquHRQ3rfONvGvUrPhuL/W6AjPf12ZGU0whsYDGbTarfoNW
 7XiO4O1LvJExoNV0UZZv8VT0GG5fWfT1nEnxmSFzDjlHgRfz6dJFJ9UpuTYIY+1l/L5NmyZ
 ld3uyriGFjXdznlxssYow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wIW+lumFlgs=:674Y7IfMPHyjG9J+1mos6/
 9BF7qWcoYj7xT7b+xq+hOX1MJPkx0Funfi+O3SGYgOjjlTB1RlDtjDCjOGQsT8KasXZWn8J3B
 pSguIgPpOqV3lbesAdMl7k0T7VagkRPDjVTobBhzyAM1ziq5voyjkZrJ6LzUgZgvNYLHI76LW
 HGifdWFO1nKWT97tR9UvTLy0ipZ9b9EZw81EndeD5IIrVJeX9oEBrnM6GJV3Ryu3hsw5csqZn
 vsAfSk4ehrrcKbaWnqmnvxqt6VcxWKSm5IT19VAJdqKAgHZvUpX0yM2ESE+92rnKYmY2pKU98
 HDT1LLO2JFzoWOtFOImW5ef45slmUiaP+y4id76wGXk9xX6N315vUnoLABoK9M4OGFMA2qejn
 30Pk0g0vmnm37S2iiSIfEM9CuzY6gxM2FKeq1GbIzBTnYj1Jxz4Gyc/c9zMu3QlPuzwd9j1rr
 VTtn7ykm42nPPKOr8LjeBZ8Frj/cSuKqSmXSZSsB8mAVteFY83IEulDP3yx+ho7lQHyumZK2n
 tYQvllIlQMiYcYZvzhIsL8anA7e/SbF4dx3+RgxcUT9hWCXIHYmv757BBjfQL9UBrk1t90aJW
 IOK7zNG8r4V9SrtkR23+WBNqPw2TinGHRYFaz86fyacq3tuPxLS6LFw/OHkm4IeqmPHtDR9w9
 zdTrGzkb27wUUflybQ4KkIO6fcny87PXbidklCjc0BBR5VcaVXSS3RFy82DW6APxeHc1oxoHN
 jh7TgrZI3ovrOiDfDdU01izL0zhDT62jS3miV1Kz8/BRHIKWVVOGJ/ezNdg=
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi folks,


we've got lots of cases, where ->request_port() / ->release_port()
are just (request|release)_mem_region calls, where the parameter
values are practicall known after the device is initialized (*1).
The only preparation needed for that is changing the individual
drivers to initialize mapsize field on probing (*2).

I see two practical options for that:

a) introduce generic helpers, which are assigned as driver callbacks
   instead of the currently used driver specific ones.

b) introduce a flag which tells the serial core to do that.


What's your oppinion on that ?

If you like, I can prepare some patches and post them here.


--mtx

*1) this also can be done w/ 8250, even though currently an extra
function is called to compute the io size - I've already sent a
patch for that some time ago.
*2) already sent patches for that, a while go.

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
