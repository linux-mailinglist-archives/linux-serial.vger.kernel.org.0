Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5B41D507
	for <lists+linux-serial@lfdr.de>; Thu, 30 Sep 2021 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348941AbhI3IGV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Thu, 30 Sep 2021 04:06:21 -0400
Received: from comms.puri.sm ([159.203.221.185]:35176 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348979AbhI3IFr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 04:05:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C7B57E114A;
        Thu, 30 Sep 2021 01:03:54 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DGMzyBi4lGRH; Thu, 30 Sep 2021 01:03:53 -0700 (PDT)
Message-ID: <a01be64e31fbeb910b237ce8b8031fe20f245c7e.camel@puri.sm>
Subject: Re: [RFC 00/19] Add interconnect and devfreq support for i.MX8MQ
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     a.fatoum@pengutronix.de, adrian.hunter@intel.com,
        aisheng.dong@nxp.com, catalin.marinas@arm.com,
        cw00.choi@samsung.com, devicetree@vger.kernel.org,
        djakov@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        myungjoo.ham@samsung.com, robh@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, ulf.hansson@linaro.org, will.deacon@arm.com
Date:   Thu, 30 Sep 2021 10:03:46 +0200
In-Reply-To: <YVRRomS8ut6NjYlV@ryzen>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
         <20210924102026.2679952-1-martin.kepplinger@puri.sm>
         <YVRRomS8ut6NjYlV@ryzen>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am Mittwoch, dem 29.09.2021 um 14:44 +0300 schrieb Abel Vesa:
> On 21-09-24 12:20:26, Martin Kepplinger wrote:
> > hi Abel,
> > 
> > thank you for the update (this is actually v2 of this RFC right?)!
> > 
> > all in all this runs fine on the imx8mq (Librem 5 and devkit) I
> > use. For all
> > the pl301 nodes I'm not yet sure what I can actually test / switch
> > frequencies.
> > 
> 
> You can start by looking into each of the following:
> 
>  $ ls -1d /sys/devices/platform/soc@0/*/devfreq/*/trans_stat
> 
> and look if the transitions happen when a specific driver that is a
> icc user suspends.
> 
> You can also look at:
> 
>  /sys/kernel/debug/interconnect/interconnect_summary 
> 
> and:
> 
>  /sys/kernel/debug/interconnect/interconnect_graph
> 
> > But I still have one problem: lcdif/mxfb already has the
> > interconnect dram
> > DT property and I use the following call to request bandwidth:
> > https://source.puri.sm/martin.kepplinger/linux-next/-/commit/d690e4c021293f938eb2253607f92f5a64f15688
> > (mainlining this is on our todo list).
> > 
> > With your patchset, I get:
> > 
> > [    0.792960] genirq: Flags mismatch irq 30. 00000004 (mxsfb-drm)
> > vs. 00000004 (mxsfb-drm)
> > [    0.801143] mxsfb 30320000.lcd-controller: Failed to install IRQ
> > handler
> > [    0.808058] mxsfb: probe of 30320000.lcd-controller failed with
> > error -16
> > 
> > so the main devfreq user (mxsfb) is not there :) why?
> > 
> 
> OK, I admit, this patchset doesn't provide support for all the icc
> consumer drivers.
> But that should come at a later stage. I only provided example like
> fec and usdhc, to show
> how it all fits together.
> 
> > and when I remove the interconnect property from the lcdif DT node,
> > mxsfb
> > probes again, but of course it doesn't lower dram freq as needed.
> > 
> > Do I do the icc calls wrong in mxsfb despite it working without
> > your
> > patchset, or may there be something wrong on your side that breaks
> > the mxsfb IRQ?
> > 
> 
> Do you have the following changes into your tree?
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi               
> index 00dd8e39a595..c43a84622af5
> 100644                                                               
>            
> ---
> a/arch/arm64/boot/dts/freescale/imx8mq.dtsi                          
>                                         
> +++
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi                          
>                                         
> @@ -524,7 +524,7 @@ lcdif: lcd-controller@30320000
> {                                                             
>                                                   <&clk
> IMX8MQ_VIDEO_PLL1>,                                      
>                                                   <&clk
> IMX8MQ_VIDEO_PLL1_OUT>;                                  
>                                 assigned-clock-rates = <0>, <0>, <0>,
> <594000000>;                               
> -                               interconnects = <&noc
> IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;                    
> +                               interconnects = <&icc
> IMX8MQ_ICM_LCDIF &icc IMX8MQ_ICS_DRAM>;                    
>                                 interconnect-names =
> "dram";                                                     
>                                 status =
> "disabled";                                                          
>    
>                                                                      
>                                             
> @@ -1117,7 +1117,7 @@ mipi_csi1: csi@30a70000
> {                                                                  
>                                          <&src
> IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET>,                            
>                                          <&src
> IMX8MQ_RESET_MIPI_CSI1_ESC_RESET>;                                
>                                 fsl,mipi-phy-gpr = <&iomuxc_gpr
> 0x88>;                                           
> -                               interconnects = <&noc IMX8MQ_ICM_CSI1
> &noc IMX8MQ_ICS_DRAM>;                     
> +                               interconnects = <&icc IMX8MQ_ICM_CSI1
> &icc IMX8MQ_ICS_DRAM>;                     
>                                 interconnect-names =
> "dram";                                                     
>                                 status =
> "disabled";                                                          
>    
>                                                                      
>                                             
> @@ -1169,7 +1169,7 @@ mipi_csi2: csi@30b60000
> {                                                                  
>                                          <&src
> IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET>,                            
>                                          <&src
> IMX8MQ_RESET_MIPI_CSI2_ESC_RESET>;                                
>                                 fsl,mipi-phy-gpr = <&iomuxc_gpr
> 0xa4>;                                           
> -                               interconnects = <&noc IMX8MQ_ICM_CSI2
> &noc IMX8MQ_ICS_DRAM>;                     
> +                               interconnects = <&icc IMX8MQ_ICM_CSI2
> &icc IMX8MQ_ICS_DRAM>;                     
>                                 interconnect-names =
> "dram";                                                     
>                                 status =
> "disabled";                                                          
>    
> 
> I forgot to update these in the current version of the patchset. Will
> do in the next version.
> 
> Also, would help a lot if you could give me a link to a tree you're
> testing with.
> That way I can look exactly at what's going on.
> 
> 


thanks Abel, with the above fix of existing interconnects properties my
system runs as expected and here's the output of

for each in `ls -1d /sys/devices/platform/soc@0/*/devfreq/*`; do echo
$each; cat $each/trans_stat; done

for mxsfb requesting (max) bandwith (display on):

/sys/devices/platform/soc@0/32700000.noc/devfreq/32700000.noc
     From  :   To
           : 133333333 400000000 800000000   time(ms)
  133333333:         0         1         0       624
  400000000:         0         0         1        28
* 800000000:         1         0         0     30624
Total transition : 3
/sys/devices/platform/soc@0/3d400000.memory-
controller/devfreq/3d400000.memory-controller
     From  :   To
           :  25000000 100000000 800000000   time(ms)
   25000000:         0         0         1       620
  100000000:         0         0         0         0
* 800000000:         1         0         0     30652
Total transition : 2
/sys/devices/platform/soc@0/soc@0:pl301@0/devfreq/soc@0:pl301@0
     From  :   To
           :  25000000 133333333 333333333   time(ms)
   25000000:         0         0         1       616
  133333333:         0         0         0         0
* 333333333:         1         0         0     30668
Total transition : 2
/sys/devices/platform/soc@0/soc@0:pl301@1/devfreq/soc@0:pl301@1
     From  :   To
           :  25000000 266666666   time(ms)
*  25000000:         0         0     31284
  266666666:         0         0         0
Total transition : 0
/sys/devices/platform/soc@0/soc@0:pl301@2/devfreq/soc@0:pl301@2
     From  :   To
           :  25000000 800000000   time(ms)
*  25000000:         0         0     31288
  800000000:         1         0         0
Total transition : 1
/sys/devices/platform/soc@0/soc@0:pl301@3/devfreq/soc@0:pl301@3
     From  :   To
           :  25000000 800000000   time(ms)
*  25000000:         0         0     31292
  800000000:         1         0         0
Total transition : 1
/sys/devices/platform/soc@0/soc@0:pl301@4/devfreq/soc@0:pl301@4
     From  :   To
           :  25000000 333333333   time(ms)
   25000000:         0         1       648
* 333333333:         0         0     30652
Total transition : 1
/sys/devices/platform/soc@0/soc@0:pl301@5/devfreq/soc@0:pl301@5
     From  :   To
           :  25000000 500000000   time(ms)
*  25000000:         0         0     31304
  500000000:         1         0         0
Total transition : 1
/sys/devices/platform/soc@0/soc@0:pl301@6/devfreq/soc@0:pl301@6
     From  :   To
           :  25000000 500000000   time(ms)
*  25000000:         0         0     31308
  500000000:         0         0         0
Total transition : 0
/sys/devices/platform/soc@0/soc@0:pl301@7/devfreq/soc@0:pl301@7
     From  :   To
           :  25000000 128000000 500000000   time(ms)
*  25000000:         0         0         0     31312
  128000000:         0         0         0         0
  500000000:         1         0         0         0
Total transition : 1
/sys/devices/platform/soc@0/soc@0:pl301@8/devfreq/soc@0:pl301@8
     From  :   To
           :  25000000 133333333   time(ms)
*  25000000:         0         0     31316
  133333333:         0         0         0
Total transition : 0
/sys/devices/platform/soc@0/soc@0:pl301@9/devfreq/soc@0:pl301@9
     From  :   To
           :  25000000 133333333 266666666   time(ms)
   25000000:         0         0         5      1052
  133333333:         0         0         0         0
* 266666666:         5         0         0     30268
Total transition : 10


but with display off (mxsfb not requesting anything), I get the same
fast freqs for noc and memory-controller. They should use the lowest
freqs. Only pl301@4 switches to 25mhz in that case. That's odd.

said (still) out-of-tree mxsfb request is
https://source.puri.sm/martin.kepplinger/linux-next/-/commit/ee7b1453295932da1e292b734afa7a03651ad9ba

and the exact tree I'm running for the above is
https://source.puri.sm/martin.kepplinger/linux-next/-/commits/5.15-rc3/librem5__integration_byzantium_test_new_devfreq_interconnect

thanks,

                              martin

