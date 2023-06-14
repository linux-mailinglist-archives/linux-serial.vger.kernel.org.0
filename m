Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE8E71FDB6
	for <lists+linux-serial@lfdr.de>; Fri,  2 Jun 2023 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjFBJXu (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 2 Jun 2023 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBJXL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Jun 2023 05:23:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475AE173B
        for <linux-serial@vger.kernel.org>; Fri,  2 Jun 2023 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685697675; x=1717233675;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8+SqG5yt48nSQj78H2qmhlBVXKEybP7UrVeQiiI+0js=;
  b=d7ZhteANJVO6Y8OoGYAp7Tx2YZ4hdjHMyKBGqwzbjmNiKlQ3Mi7Ny+tt
   1cZYWx3DD05P2LD9Kr5v3tzIMVV4sNMBL52wJV7H1BnN/8PxC72cslrvY
   Kv7jYbT/7VgynxuyqRtMCJUZCpL6RXlxCKRu7WPhDhkJKE0J0bdZhdFrm
   7BnvKFvkoADwCRJPX0lT2vQCwakopG+veYvX1K3+q0Jt0Bt46heAtEy1T
   1fdTW96bMcWSYL46eKWIwnoDyx4oLPO6kg/VIyRtdXkDoOiW05emWOySZ
   Fiii09RVywDiTyLP191anfOHuKDHK9BQwldnoD0c6JP5I/w150FM26kqx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358257098"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358257098"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 02:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="740767214"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="740767214"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 02:21:12 -0700
Date:   Fri, 2 Jun 2023 12:21:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, kernel@pengutronix.de,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
In-Reply-To: <73474ddb-5183-69c8-3943-bc2c62aa13e9@linux.intel.com>
Message-ID: <cb975bcf-eb5b-a620-880-d0dbef684669@linux.intel.com>
References: <20230531083230.2702181-1-u.kleine-koenig@pengutronix.de> <1bdec338-6954-7b2f-e8e3-f19f211c4ce3@linux.intel.com> <20230531100443.jeg4q73fz4yx4pi6@pengutronix.de> <9eab900-9387-4db2-3f24-29d4d1dcb411@linux.intel.com> <20230531104010.k2rgnicltwy6wive@pengutronix.de>
 <20230531175126.vqoqa2flhtbboy2t@pengutronix.de> <73474ddb-5183-69c8-3943-bc2c62aa13e9@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-639012300-1685697674=:1742"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-639012300-1685697674=:1742
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 1 Jun 2023, Ilpo J�rvinen wrote:

> On Wed, 31 May 2023, Uwe Kleine-K�nig wrote:
> 
> > Hello Ilpo,
> > 
> > On Wed, May 31, 2023 at 12:40:10PM +0200, Uwe Kleine-K�nig wrote:
> > > On Wed, May 31, 2023 at 01:09:01PM +0300, Ilpo J�rvinen wrote:
> > > > On Wed, 31 May 2023, Uwe Kleine-K�nig wrote:
> > > > 
> > > > > On Wed, May 31, 2023 at 12:47:54PM +0300, Ilpo J�rvinen wrote:
> > > > > > On Wed, 31 May 2023, Uwe Kleine-K�nig wrote:
> > > > > > 
> > > > > > > The need to handle the FSL variant of 8250 in a special way is also
> > > > > > > present without console support. So soften the dependency for
> > > > > > > SERIAL_8250_FSL accordingly.
> > > > > > > 
> > > > > > > This issue was identified by Dominik Andreas Schorpp.
> > > > > > > 
> > > > > > > To cope for CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y, 8250_fsl.o
> > > > > > > must be put in the same compilation unit as 8250_port.o because the
> > > > > > > latter defines some functions needed in the former and so 8250_fsl.o
> > > > > > > must not be built-in if 8250_port.o is available in a module.
> > > > > > > 
> > > > > > > Signed-off-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>
> > > > > > > ---
> > > > > > > Hello,
> > > > > > > 
> > > > > > > (implicit) v1 was already applied by Greg (a0807ca158e0 in tty-testing)
> > > > > > > but that didn't handle CONFIG_SERIAL_8250=m + CONFIG_SERIAL_8250_FSL=y
> > > > > > > correctly which was pointed out by the 0-day bot. (Thanks!)
> > > > > > 
> > > > > > That would warrant Reported-by (0-day's reports give you the tag).
> > > > > 
> > > > > I'd add this tag if I created a commit that fixes the broken commit.
> > > > > However I understood that if a v2 patch fixes a v1 that was broken, the
> > > > > tag is not to be added?! I don't feel strong here however, so if people
> > > > > agree that the tag should be there, I can add it.
> > > > > 
> > > > > > > That wasn't a problem before because SERIAL_8250_CONSOLE depends on
> > > > > > > SERIAL_8250=y.
> > > > > > > 
> > > > > > > Having said that I wonder if there are a few more .o files that should
> > > > > > > better be used with 8250_base-$(CONFIG_SERIAL_8250_XXX) instead of
> > > > > > > obj-$(CONFIG_SERIAL_8250_XXX).
> > > > > > > 
> > > > > > > Best regards
> > > > > > > Uwe
> > > > > > > 
> > > > > > >  drivers/tty/serial/8250/Kconfig  | 2 +-
> > > > > > >  drivers/tty/serial/8250/Makefile | 2 +-
> > > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > > > > > > index 5313aa31930f..10c09b19c871 100644
> > > > > > > --- a/drivers/tty/serial/8250/Kconfig
> > > > > > > +++ b/drivers/tty/serial/8250/Kconfig
> > > > > > > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > > > > > >  
> > > > > > >  config SERIAL_8250_FSL
> > > > > > >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> > > > > > > -	depends on SERIAL_8250_CONSOLE
> > > > > > > +	depends on SERIAL_8250
> > > > > > 
> > > > > > Why this cannot simply be:
> > > > > > 	depends on SERIAL_8250=y
> > > > > 
> > > > > This doesn't work, because then the FSL-workarounds are missing if the
> > > > > 8250 driver is compiled as a module.
> > > > 
> > > > How can 8250 driver be a module and fsl still get enabled?
> > > 
> > > It works. With my patch applied:
> > > 
> > > 	$ make allmodconfig
> > > 	$ grep -E 'CONFIG_SERIAL_8250(_FSL)?\>' .config
> > > 	CONFIG_SERIAL_8250=m
> > > 	CONFIG_SERIAL_8250_FSL=y
> > > 
> > > > What I think (not a Kconfig expert for sure) would happen is that 8250_fsl 
> > > > won't be enabled at all if CONFIG_SERIAL_8250=m because it depends on 
> > > > SERIAL_8250=y.
> > > 
> > > That's not how it seems to be ...
> > 
> > If this convinces you that the patch is fine, an ack would be nice as
> > gregkh signaled that there is some pending discussion he is waiting to
> > end before applying this patch.
> 
> Ah, so you want to have SERIAL_8250_FSL=y always when SERIAL_8250 is 
> there. I can't see another way around it besides the moving you made.
> 
> Acked-by: Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>

After some more thinking, it looks make allmodconfig is not going to work
because of this:

arch/powerpc/kernel/legacy_serial.c:            port->handle_irq = fsl8250_handle_irq;

obj-$(CONFIG_PPC_UDBG_16550)    += legacy_serial.o udbg_16550.o

config PPC_UDBG_16550
        bool

-- 
 i.

--8323329-639012300-1685697674=:1742--
