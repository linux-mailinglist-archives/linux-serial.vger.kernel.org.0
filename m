Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489FF77854
	for <lists+linux-serial@lfdr.de>; Sat, 27 Jul 2019 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfG0K66 (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 27 Jul 2019 06:58:58 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47775 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfG0K66 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Jul 2019 06:58:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E6C1B471;
        Sat, 27 Jul 2019 06:58:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 27 Jul 2019 06:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=szwEeWdTqY4dEKk9Z63jyjEiCaO
        tx3ARQ8/K9O89API=; b=efIE9QnH6tAiJ/Cp8lLE92rMQj0S5buXf3RJOk8wJ7y
        d1xybCQYgQua9GcbAsNSeYgsxYdYve1JQwNWS7EMsOwNepILHFjkpE4bRT+ok+lt
        VdHrvThO5aArbzGJO4xhptLhuWkY5JYXz2fIjgK7T8/pYSteIv6W+uBrxTSBHTzS
        1RV7w1hoXqbholKY9quNuJCnO8j2noPvwQlYS13qgWqv/P/duxbcY7WjCuK8b8sz
        PJaJAw3KXjlEeURHQONvWtAkuc2lWeCF0pEipFKBlkfJWXbcz0YnaR3Ovz2mSvyb
        GKd7ibXAJCC9F2+Y0TuvBJMK8HpxbeaQbxiETsq7hKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=szwEeW
        dTqY4dEKk9Z63jyjEiCaOtx3ARQ8/K9O89API=; b=vJkrm2pskRXxusXi62fTqX
        k2yjyjPbkBXG9h3wxsVmm/BPD34BFHu94gBG4O9FCl3WbNCd/fOGqWan2s5Wsx1E
        U30Ta1kbyX2Gp3taeEqkcZFqGoPpFgxLGMZ9MYzC479lttuRxwBdVB0Vz6T1djc9
        E7UxnOxesQRJU/dHE4EB5RGuO/iuef0oeXwZjUMtF+2NT22X8ug4hMevEqYahj3D
        SI78bTqd6LDMHq8kiM4oa5Mk2ghYXYyy09Lx4buNNPbovVG5rj7pGY7GznD/M5Ka
        l1yeoA+dhshhVzmZ8HmlXkloJ6pxZDkKAB3DKDuuNftZJU2IjdKBo/ne1fnIYK5w
        ==
X-ME-Sender: <xms:bi48Xf0R76qJgOH1yzt9NUEo87antQ5IRHvbxSCSaBTy_c4KbkcPzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:bi48XZn9B-SrEn7nAsNX6K-RxKYCMcg_WL-2MlUQCuswTgEobs60VA>
    <xmx:bi48XV4n-6MolJGgBeK8dzO9VZzm-691hbH4fJwJucU80m9F5y3yWg>
    <xmx:bi48XSkMfnzK4kiVoyrHCJkF9y6h5-fCqLeZv4wagXJOluKOmknZxQ>
    <xmx:bi48XUYDrljIxkWWPKrhgW-M1V4JCFOFZclwG0cvmrWoraUf2dzbGQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5A8A380074;
        Sat, 27 Jul 2019 06:58:53 -0400 (EDT)
Date:   Sat, 27 Jul 2019 12:58:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_exar: Clear buffer before shutdown
Message-ID: <20190727105851.GD458@kroah.com>
References: <20190723143632.22427-1-robert.middleton@rm5248.com>
 <20190725100229.GB20445@kroah.com>
 <CAKpcJVZpB-b=Z9r-q9fxoN-asiLnde3ea+8G=XGmyigWOWXmgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpcJVZpB-b=Z9r-q9fxoN-asiLnde3ea+8G=XGmyigWOWXmgQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 26, 2019 at 12:02:06PM -0400, Robert Middleton wrote:
> > What if the hardware is locked up?  Will this sit and spin forever?
> 
> I assume so; what is the correct way to do this?  The
> manufacturer-provided drivers do something similar but with a counter
> that will count up to 1000 before exiting the loop so as to not lock
> up.

1000 sounds good to me :)

> > Shouldn't you also have a timeout for the flush?
> 
> Flush from the system?  The problem that I have been seeing is that
> when you do something like "echo text > /dev/ttyS1", only the first
> character will be printed out.  This (should) be waiting for that to
> happen, since it checks the hardware to ensure that the hardware
> buffers are clear and that there are no more characters waiting to be
> written to the hardware buffer.
> 
> I'm also not sure if the above means that there is a problem with the
> serial_8250 driver in general, as I don't have another piece of
> hardware available that uses that driver.

If you time out after 1000 iterations of the loop, that should solve my
worries here, please fix it up that way and I'll be glad to take the
change.

thanks,

greg k-h
