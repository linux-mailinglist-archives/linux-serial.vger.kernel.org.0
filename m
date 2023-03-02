Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADAD6A8846
	for <lists+linux-serial@lfdr.de>; Thu,  2 Mar 2023 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCBSHj (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 2 Mar 2023 13:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBSHi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 13:07:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B6636FFC
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 10:07:37 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p6so18673pga.0
        for <linux-serial@vger.kernel.org>; Thu, 02 Mar 2023 10:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677780457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVufqt2q+1OxmxXvizVLiJnEoIcg0hYQSdi895bILhk=;
        b=jfgW0mkdIo+66M6yepHxjJnbjVud5yqIQC8vDG9Pn/LBIPcajv22gvOrpN3l6nLvX3
         DbdbiHN9YfilFGa6SJ2f4BHhtD0NfhErKqNJe/MJlyWfaYdXKPLdBVbQac5DBUUZojH1
         JQHAefreZuFn4LAep+mafMpxQqNLcTh4nc5/v87w4UGW0tQaQ2hePzS+S71JfZicMkWA
         mFvu+oaimj7VzuSg/fKGT840NPbN9tWGNOHqMVjXpv+clCs70u8CAe1apnD5zQbfpnrp
         GhxADdc0kAWpuDLxpC9/3/iqC9tNdOH64F1c2QIWhUIYwi4zAWzFbULGjef0YZBs2CiP
         33Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677780457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVufqt2q+1OxmxXvizVLiJnEoIcg0hYQSdi895bILhk=;
        b=vNRqHD9/hrc4Mm32Mm1JBFpXw/64KfB7ibTs4H7nuaK8fr/FLZKt8CdSg6QKrbdQfm
         LW4YLuh/q3Nv4gnt8daSzpn2F4siK8O1oM+jffVyetikruulpmfMLw6P8cyEIP1Q8xss
         Ql03pB8cKyfYJ+9RoH6H+I8mubzr7mzSNdCV6Sv8uvXixEZ45ZMsxqR6VanXTZQVwsfQ
         3zNJP4ek9H6UToRhfmxtIEPpIzczpzszqQKcEsd3Ul9JrlDIGLDE3wOILd+Ut4P1hKDe
         c/07Zwiw7zj32kdU3aYXPHADOvwB2NLX085haK2D20rBHzE8R12XoZUHlVg2BurxSD26
         Utfg==
X-Gm-Message-State: AO0yUKVmzBwqqAzAT7Oy/ulwJt+XyPdt6Kf7Jz8Zf2/cEU18qkwWcQQn
        x9HXG+NPEOKZCp6z8SCxLhXMmhfaU0fHfp4zdfy0OQ==
X-Google-Smtp-Source: AK7set+wJr4ZeaN1idB6Fcp8tiIPrlabfRBjutTrKKHxAjXUMLEp+20opx4fQEeQAeW/CXIdPZ6fMZQ9TwsClnLtryA=
X-Received: by 2002:a62:8281:0:b0:5df:9809:6220 with SMTP id
 w123-20020a628281000000b005df98096220mr4372776pfd.3.1677780456826; Thu, 02
 Mar 2023 10:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20230302023509.319903-1-saravanak@google.com> <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
 <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com> <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com>
In-Reply-To: <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Mar 2023 10:07:00 -0800
Message-ID: <CAGETcx_crW9BJmUoVJv1iU-KTr+9WPp_bpfrKoxzQiJGpqDgAA@mail.gmail.com>
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 2, 2023 at 9:51=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.c=
om> wrote:
>
>
>
> On 3/2/2023 9:20 AM, Saravana Kannan wrote:
> > On Thu, Mar 2, 2023 at 9:01=E2=80=AFAM Stefan Wahren <stefan.wahren@i2s=
e.com> wrote:
> >>
> >> Hi Saravana,
> >>
> >> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
> >>> This allow fw_devlink to do dependency tracking for serdev devices.
> >>>
> >>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> >>> Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17=
e5@gmail.com/
> >>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>
> >> since this fixes an issue on Raspberry Pi 4, shouldn't this be mention=
ed
> >> in the commit message and providing a Fixes tag?
> >
> > So RPi 4 was never creating a device links between serdev devices and
> > their consumers. The error message was just a new one I added and we
> > are noticing and catching the fact that serdev wasn't setting fwnode
> > for a device.
> >
> > I'm also not sure if I can say this commit "Fixes" an issue in serdev
> > core because when serdev core was written, fw_devlink wasn't a thing.
> > Once I add Fixes, people will start pulling this into stable
> > branches/other trees where I don't think this should be pulled into
> > older stable branches.
>
> That is kind of the point of Fixes: tag, is not it? It is appropriate to
> list a commit that is not specific to serdev, but maybe a particular
> point into the fw_devlink history.

I don't want to pick an arbitrary point in fw_devlink as I don't want
people picking this up with some old version of fw_devlink and having
to support it there.

> Given this did not appear to have a
> functional impact, we could go without one.

This is my take too.

Greg/Rob,

If you really want a Fixes here, can you please just add it instead of
a v2 patch just for that? You can use this commit:
3fb16866b51d driver core: fw_devlink: Make cycle detection more robust

-Saravana
