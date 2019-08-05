Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6E815A1
	for <lists+linux-serial@lfdr.de>; Mon,  5 Aug 2019 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHEJjC (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 5 Aug 2019 05:39:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:32455 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfHEJjC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Aug 2019 05:39:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 02:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="176262725"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2019 02:38:35 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1huZRp-00052J-Ow; Mon, 05 Aug 2019 12:38:33 +0300
Date:   Mon, 5 Aug 2019 12:38:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/3] serial: 8250_exar: Refactor exar_shutdown()
Message-ID: <20190805093833.GG23480@smile.fi.intel.com>
References: <20190802153422.11131-1-andriy.shevchenko@linux.intel.com>
 <20190802153422.11131-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVb6W+_VbPdYVB6fNpy5h=u=Dv_-AwZLuFZ8=Ypj=620rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpcJVb6W+_VbPdYVB6fNpy5h=u=Dv_-AwZLuFZ8=Ypj=620rw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 02, 2019 at 08:52:25PM -0400, Robert Middleton wrote:
> Andy,
> 
> Correct me if I'm wrong here, but will that still work correctly?
> That will break once the buffer on the exar chip is clear, but there
> could potentially be characters still in the kernel
> buffer(uart_circ_empty would not be true)

Thank you for the comment, I agree it is not equivalent,
I will fix it in next version.

-- 
With Best Regards,
Andy Shevchenko


