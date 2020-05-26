Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D519F83B
	for <lists+linux-serial@lfdr.de>; Mon,  6 Apr 2020 16:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgDFOvH (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 6 Apr 2020 10:51:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36858 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgDFOvH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 10:51:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id b1so15022792ljp.3;
        Mon, 06 Apr 2020 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zv73VIDMB5XkekQFWexD93hVRqBSU9t2eLoE2vj9UHU=;
        b=g10UmtjGhpUF4egpxzhwBHY2Htxf8KmrUkHxPBB8WnS6ig+ojI4TqK5eROxoVlQlEM
         f3TZMMYHTLkAPR0Jie1hY6q8MyTys95O35rJdDbrMDrGvhawoHlnMxtoeb8f19CfZDqm
         JbUDpyeEC7TAVw6jv8j7kPmxm/m4/2jh/3MXUzqyehfSHSQczIOYuA9fuFe9lDWCdkTd
         RsPtbxKxccHZh0iDySbuL16pAJoadEKhGgXL9bBAQeeAMgZRiMJzXNQhiY1w4BoyaBky
         JGDunXdRdauVsVXAy0sikq610RZvfnaF1Ya1QMReef4rDzuPM4/bG5KKLW1f2fhyhGF0
         QOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zv73VIDMB5XkekQFWexD93hVRqBSU9t2eLoE2vj9UHU=;
        b=HBPBuyZYDtVtfI4vLZb7C111phbBiOkaMk6Jed8TBXvE+71uT/xW/c2FPEYVRWCHXC
         3uLKNp9YZyksX/THOENxKouLNQc+YvSLKxUIkvnhORGZ8s4cOW+cvtGebW/mtPZrpqSr
         EwO/y3NxA15uYcM+q6buwUw38Yxp4w2frJfw0DNiIyno5bbzoe/adZCENMEbBmiSk0TK
         4PklmB/Qyc5qvTDw6ugEoqPZirAw6rj37jgm3MC3nEVdKbAvrjoouQ6H4z3HVtOgk0zi
         9QIT+8ds/22OzeORHW1mbvlOqZ74j9cgoUHpbKVNE9SX+tCEsLNWQdHTras47ZKYqOkJ
         sK2A==
X-Gm-Message-State: AGi0Pua8Tvy5GRPnB+CAGBcj98zWzdt+evgsTG1Vm6g0YTFYQ1YEMTEl
        A4pIfFBZgGmpt11drHK8GxaccYrZvZbPqvDZ1j4=
X-Google-Smtp-Source: APiQypJi0emqePRH1uMy/xeeuR1IoxBklmiqhMdh0JCTu6KYZOO2/ISfO6nJNFtksILbBchb6HPD3MHfceqTPc39eQw=
X-Received: by 2002:a2e:b4d1:: with SMTP id r17mr12338199ljm.117.1586184664709;
 Mon, 06 Apr 2020 07:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200403174942.9594-1-michael@walle.cc>
In-Reply-To: <20200403174942.9594-1-michael@walle.cc>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 6 Apr 2020 11:51:27 -0300
Message-ID: <CAOMZO5AGEjqmsgYrhwW-3HjAHszmChLyZXC0PWDrXr=YP5mu2A@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: make coverity happy
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 3, 2020 at 2:50 PM Michael Walle <michael@walle.cc> wrote:
>
> Coverity reports the following:
>
>   var_compare_op: Comparing chan to null implies that chan might be null.
>
>   1234        if (chan)
>   1235                dmaengine_terminate_all(chan);
>   1236
>
>   Dereference after null check (FORWARD_NULL)
>   var_deref_op: Dereferencing null pointer chan.
>
>   1237        dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
>
> Technically, this is correct. But lpuart_dma_rx_free() is guarded by
> lpuart_dma_rx_use which is only true if there is a dma channel, see
> lpuart_rx_dma_startup(). In any way, this looks bogus. So remove
> the superfluous "if (chan)" check and make coverity happy.
>
> Fixes: a092ab25fdaa ("tty: serial: fsl_lpuart: fix DMA mapping")
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reported-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
