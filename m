Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C03568CB0
	for <lists+linux-serial@lfdr.de>; Wed,  6 Jul 2022 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiGFP0V (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 6 Jul 2022 11:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGFP0U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Jul 2022 11:26:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB1C29
        for <linux-serial@vger.kernel.org>; Wed,  6 Jul 2022 08:26:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g1so12102279edb.12
        for <linux-serial@vger.kernel.org>; Wed, 06 Jul 2022 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N+FbSyALgm9lbOpyIy2v3Y7I0J+XerdtP2UQklPiSpI=;
        b=LRUZlJxKqdqYRSw/yeFrbKJA0IhDA/PmPs0D7vdmRBAx2GdS7Y8MLTUV5W5sX5FX+M
         Nx29ts/Ve1YdYOfOKx8vSU5/skbgooKFUwhzjYepC7bTcR3+39gfeAMQ/+9ntMvsKF4Y
         qlEmgbeT8UGwRKNuVHeeoW9MC6YtYRRNqbw6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N+FbSyALgm9lbOpyIy2v3Y7I0J+XerdtP2UQklPiSpI=;
        b=WhiP5PT3rx985TjhQTr7C1ZXmqjbL+h6i8B/4sf/Ws+JFFkSABByBnM1JTmEdizVLo
         IFEBWIoL2yrevBghHITBLUgq1p8h8R4UCSBZ26vSDD00d/1BPuzxvHTwekil61IJ1Kns
         YMFBbfHOOolRYtMQVLcGb1EbGUNIy0IOIlq9aXjY2zDSk3dA4deFOPV476H7yTvNG/c3
         irMB8BSGiEUnHwNkei+K/773QRyzgMDsbWGotTzUHebeTulbYzYZz8Flo3ZWjIv0RTLH
         surVoUsDvBQOJeBeKc/dmWcGDq8OMc0VsKqJkjVRlvyI0Yq6ecXqhG7ncz7rPnGVGoL0
         tl0w==
X-Gm-Message-State: AJIora+pTO62hePW9LhshLit9a6+TTLNqBtGGpmSHoCU1EfjMAAdBqWy
        nDYh90f3y72iDs9YUZk0Y9BGmCyIKP/8D4Ms
X-Google-Smtp-Source: AGRyM1vF3V3+vfPz1DsVip1vLnCtZbOsfdK1VLY1w3WKTJTBadXe89QVM+6rtg0zJNHu+FZKU79FTQ==
X-Received: by 2002:a05:6402:4011:b0:43a:84de:26b1 with SMTP id d17-20020a056402401100b0043a84de26b1mr6959127eda.402.1657121176947;
        Wed, 06 Jul 2022 08:26:16 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id es25-20020a056402381900b0043a6b86f024sm6584674edb.67.2022.07.06.08.26.14
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:26:15 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id m184so9062432wme.1
        for <linux-serial@vger.kernel.org>; Wed, 06 Jul 2022 08:26:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id
 d14-20020a05600c3ace00b003a04ea45f77mr43144480wms.57.1657121174285; Wed, 06
 Jul 2022 08:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com>
 <BL0PR02MB4564A1EC37911A464BBEC260FABD9@BL0PR02MB4564.namprd02.prod.outlook.com>
 <CAD=FV=XCgsyTRT-T5jKN6c7tJ=du8gbpkMccm2VZpz+TFWyLsw@mail.gmail.com> <BL0PR02MB45643EEB3C1571E0F2364B8FFABE9@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB45643EEB3C1571E0F2364B8FFABE9@BL0PR02MB4564.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 08:26:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Up_NNd5RNJ+xLrPOHfPb_YG1ut=BjU=O2yP8w2hG9Ugw@mail.gmail.com>
Message-ID: <CAD=FV=Up_NNd5RNJ+xLrPOHfPb_YG1ut=BjU=O2yP8w2hG9Ugw@mail.gmail.com>
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
To:     "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>
Cc:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, Jul 4, 2022 at 11:57 AM Vijaya Krishna Nivarthi (Temp)
<vnivarth@qti.qualcomm.com> wrote:
>
> Hi,
>
>
> > -----Original Message-----
> > From: Doug Anderson <dianders@chromium.org>
> > Sent: Friday, July 1, 2022 8:38 PM
> > To: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>
> > Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Konrad
> > Dybcio <konrad.dybcio@somainline.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; linux-=
arm-
> > msm <linux-arm-msm@vger.kernel.org>; linux-serial@vger.kernel.org; LKML
> > <linux-kernel@vger.kernel.org>; Mukesh Savaliya (QUIC)
> > <quic_msavaliy@quicinc.com>; Matthias Kaehlcke <mka@chromium.org>;
> > Stephen Boyd <swboyd@chromium.org>
> > Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate()=
 which
> > otherwise could return a sub-optimal clock rate.
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary
> > of any links or attachments, and do not enable macros.
> >
> > Hi,
> >
> > On Fri, Jul 1, 2022 at 4:04 AM Vijaya Krishna Nivarthi (Temp) (QUIC)
> > <quic_vnivarth@quicinc.com> wrote:
> > >
> > > Hi,
> > >
> > >
> > > > -----Original Message-----
> > > > From: Doug Anderson <dianders@chromium.org>
> > > > Sent: Thursday, June 30, 2022 4:45 AM
> > > > To: Vijaya Krishna Nivarthi (Temp) (QUIC)
> > > > <quic_vnivarth@quicinc.com>
> > > > Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org;
> > > > Konrad Dybcio <konrad.dybcio@somainline.org>; Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>;
> > > > linux-arm- msm <linux-arm-msm@vger.kernel.org>;
> > > > linux-serial@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>;
> > > > Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Matthias
> > > > Kaehlcke <mka@chromium.org>; Stephen Boyd
> > <swboyd@chromium.org>
> > > > Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix
> > > > get_clk_div_rate() which otherwise could return a sub-optimal clock=
 rate.
> > > >
> > > >
> > > >
> > > > > +                               /* Save the first (lowest freq) w=
ithin tolerance */
> > > > > +                               ser_clk =3D freq;
> > > > > +                               *clk_div =3D new_div;
> > > > > +                               /* no more search for exact match=
 required in 2nd run
> > */
> > > > > +                               if (!exact_match)
> > > > > +                                       break;
> > > > > +                       }
> > > > > +               }
> > > > >
> > > > > -               prev =3D freq;
> > > > > +               div =3D freq / desired_clk + 1;
> > > >
> > > > Can't you infinite loop now?
> > > >
> > > > Start with:
> > > >
> > > > desired_clk =3D 10000
> > > > div =3D 1
> > > > percent_tol =3D 2
> > > >
> > > >
> > > > Now:
> > > >
> > > > mult =3D 10000
> > > > offset =3D 200
> > > > test_freq =3D 9800
> > > > freq =3D 9800
> > > > div =3D 9800 / 10000 + 1 =3D 0 + 1 =3D 1
> > > >
> > > > ...and then you'll loop again with "div =3D 1", won't you? ...or di=
d I
> > > > get something wrong in my analysis? This is the reason my proposed
> > > > algorithm had two loops.
> > > >
> > > >
> > >
> > > I went back to your proposed algorithm and made couple of simple
> > changes, and it seemed like what we need.
> > >
> > > a) look only for exact match once a clock rate within tolerance is
> > > found
> > > b) swap test_freq and freq at end of while loops to make it run as
> > > desired
> > >
> > >
> > >         maxdiv =3D CLK_DIV_MSK >> CLK_DIV_SHFT;
> > >         div =3D 1;
> > >
> > >         while (div < maxdiv) {
> > >                 mult =3D (unsigned long long)div * desired_clk;
> > >                 if (mult !=3D (unsigned long)mult)
> > >                         break;
> > >
> > >                 if (ser_clk)
> > >                         offset =3D 0;
> > >                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3Da=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >                 else
> > >                         offset =3D div_u64(mult * percent_tol, 100);
> > >
> > >                 /*
> > >                  * Loop requesting (freq - 2%) and possibly (freq).
> > >                  *
> > >                  * We'll keep track of the lowest freq inexact match =
we found
> > >                  * but always try to find a perfect match. NOTE: this=
 algorithm
> > >                  * could miss a slightly better freq if there's more =
than one
> > >                  * freq between (freq - 2%) and (freq) but (freq) can=
't be made
> > >                  * exactly, but that's OK.
> > >                  *
> > >                  * This absolutely relies on the fact that the Qualco=
mm clock
> > >                  * driver always rounds up.
> > >                  */
> > >                 test_freq =3D mult - offset;
> > >                 while (test_freq <=3D mult) {
> > >                         freq =3D clk_round_rate(clk, test_freq);
> > >
> > >                         /*
> > >                          * A dead-on freq is an insta-win. This impli=
citly
> > >                          * handles when "freq =3D=3D mult"
> > >                          */
> > >                         if (!(freq % desired_clk)) {
> > >                                 *clk_div =3D freq / desired_clk;
> > >                                 return freq;
> > >                         }
> > >
> > >                         /*
> > >                          * Only time clock framework doesn't round up=
 is if
> > >                          * we're past the max clock rate. We're done =
searching
> > >                          * if that's the case.
> > >                          */
> > >                         if (freq < test_freq)
> > >                                 return ser_clk;
> > >
> > >                         /* Save the first (lowest freq) within tolera=
nce */
> > >                         if (!ser_clk && freq <=3D mult + offset) {
> > >                                 ser_clk =3D freq;
> > >                                 *clk_div =3D div;
> > >                         }
> > >
> > >                         /*
> > >                          * If we already rounded up past mult then th=
is will
> > >                          * cause the loop to exit. If not then this w=
ill run
> > >                          * the loop a second time with exactly mult.
> > >                          */
> > >                         test_freq =3D max(test_freq + 1, mult);
> > >                                                      =3D=3D=3D=3Db=3D=
=3D=3D=3D
> > >                 }
> > >
> > >                 /*
> > >                  * freq will always be bigger than mult by at least 1=
.
> > >                  * That means we can get the next divider with a DIV_=
ROUND_UP.
> > >                  * This has the advantage of skipping by a whole bunc=
h of divs
> > >                  * If the clock framework already bypassed them.
> > >                  */
> > >                 div =3D DIV_ROUND_UP(freq, desired_clk);
> > >                                                        =3D=3D=3Db=3D=
=3D
> > >         }
> > >
> > >
> > > Will also drop exact_match now.
> > >
> > > Will upload v3 after testing.
> >
> > The more I've been thinking about it, the more I wonder if we even need=
 the
> > special case of looking for an exact match at all. It feels like we sho=
uld choose
> > one: we either look for the best match or we look for the one with the
> > lowest clock source rate. The weird half-half approach that we have rig=
ht
> > now feels like over-engineering and complicates things.
> >
> > How about this (again, only lightly tested). Worst case if we _truly_ n=
eed a
> > close-to-exact match we could pass a tolerance of 0 in and we'd get
> > something that's nearly exact, though I'm not suggesting we actually do=
 that.
> > If we think 2% is good enough then we should just accept the first (and
> > lowest clock rate) 2% match we find.
> >
> >     abs_tol =3D div_u64((u64)desired_clk * percent_tol, 100);
> >     maxdiv =3D CLK_DIV_MSK >> CLK_DIV_SHFT;
> >     div =3D 1;
> >     while (div <=3D maxdiv) {
> >         mult =3D (u64)div * desired_clk;
> >         if (mult !=3D (unsigned long)mult)
> >             break;
> >
> >         offset =3D div * abs_tol;
> >         freq =3D clk_round_rate(clk, mult - offset);
> >
> >         /* Can only get lower if we're done */
> >         if (freq < mult - offset)
> >             break;
> >
> >         /*
> >          * Re-calculate div in case rounding skipped rates but we
> >          * ended up at a good one, then check for a match.
> >          */
> >         div =3D DIV_ROUND_CLOSEST(freq, desired_clk);
> >         achieved =3D DIV_ROUND_CLOSEST(freq, div);
> >         if (achieved <=3D desired_clk + abs_tol &&
> >             achieved >=3D desired_clk - abs_tol) {
> >             *clk_div =3D div;
> >             return freq;
> >         }
> >
> >         /*
> >          * Always increase div by at least one, but we'll go more than
> >          * one if clk_round_rate() gave us something higher.
> >          */
> >         div =3D DIV_ROUND_UP(max(freq, (unsigned long)mult) + 1, desire=
d_clk);
>
> Wouldn=E2=80=99t DIV_ROUND_UP(freq, desired_clk) suffice here?
> freq >=3D mult-offset, else we would have hit break.

No. As you say, freq >=3D "mult-offset". That means that freq could be
=3D=3D "mult-offset", right? If offset > 0 then freq could be < mult. Then
your DIV_ROUND_UP() would just take you right back to where you
started the loop with and you'd end up with an infinite loop, wouldn't
you?


> Additionally if freq <=3D mult we would have hit return.
> So always freq > mult?
>
> And hence div++ would do the same?

I thought about it and I decided that it might not if the clock
framework skipped a whole bunch. Let's see if I can give an example.

Let's say
* "desired_clk" is 10000
* "percent_tol" is 2 (abs_tol =3D 200)
* We can make clocks 17000, 20000, 25000.

First time through the loop:

mult =3D 10000
offset =3D 200
freq =3D 17000
div =3D 2
achieved =3D 8500 (not within tolerance)

...at the end of the loop if we do "div++" then we'll end up with
div=3D3 for the next loop and we'll miss finding 20000.
...but if we do my math, we end up with:

DIV_ROUND_UP(max(17000, 10000) + 1, 10000)
DIV_ROUND_UP(17000 + 1, 10000)
DIV_ROUND_UP(17000, 10000)
2

...and that's exactly what we want.


Here's an example showing why the line "div =3D DIV_ROUND_CLOSEST(freq,
desired_clk)" is important:

* "desired_clk" is 10000
* "percent_tol" is 2 (abs_tol =3D 200)
* We can make clocks 19600, 25000.

mult =3D 10000
offset =3D 200
freq =3D 19600
div =3D 2
achieved =3D 9800

Returns 19600 and div=3D2


Here's an example showing how the clock framework rounding lets us
skip some "div"s without missing anything important:

* "desired_clk" is 10000
* "percent_tol" is 2 (abs_tol =3D 200)
* We can make clocks 24000, 30000.

mult =3D 25000
offset =3D 200
freq =3D 24000
div =3D 2
achieved =3D 12000 (not within tolerance)

div =3D DIV_ROUND_UP(max(24000, 10000) + 1, 10000)
div =3D 3

mult =3D 30000
offset =3D 600
freq =3D 30000
div =3D 3

-Doug
