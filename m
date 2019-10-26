Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB24E5D7E
	for <lists+linux-serial@lfdr.de>; Sat, 26 Oct 2019 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJZNoX (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Sat, 26 Oct 2019 09:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfJZNoW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Oct 2019 09:44:22 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162D520867;
        Sat, 26 Oct 2019 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572097462;
        bh=YCv4URIQy3pkQdHVSuQ+eQWwuJTzbg/MkOdHyTJ36e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=es/koZ9mMCa27TDLFb9+npeSxQoSzx8tu4azO/Cii5Nxn2vNy8oG4f7jw8mZW95KT
         SVq2gwXHkPyC8iCZN1BPF1Mi6YGh0TiLE4BDKqjerpn2r41iF/ttJBt+I7ZtAxlMjZ
         i950RIuSPjFb6t9bhtuQdxo1ycLuXgjx8F9/t0Lk=
Date:   Sat, 26 Oct 2019 21:44:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, leoyang.li@nxp.com, jslaby@suse.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/5] Add initial support for S32V234-EVB
Message-ID: <20191026134403.GQ14401@dragon>
References: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 16, 2019 at 03:48:22PM +0300, Stefan-Gabriel Mirea wrote:
> Eddy Petrișor (1):
>   dt-bindings: arm: fsl: Add the S32V234-EVB board
> 
> Mihaela Martinas (2):
>   arm64: Introduce config for S32
>   arm64: defconfig: Enable configs for S32V234
...
> Stoica Cosmin-Stefan (1):
>   arm64: dts: fsl: Add device tree for S32V234-EVB

Applied these 4, thanks.
