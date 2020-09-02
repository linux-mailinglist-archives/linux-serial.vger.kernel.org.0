Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D662A25A909
	for <lists+linux-serial@lfdr.de>; Wed,  2 Sep 2020 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgIBKCy (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 2 Sep 2020 06:02:54 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:55533 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBKCy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Sep 2020 06:02:54 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 07EB230037B67;
        Wed,  2 Sep 2020 12:02:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DD1AD10F5B6; Wed,  2 Sep 2020 12:02:47 +0200 (CEST)
Date:   Wed, 2 Sep 2020 12:02:47 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: core: Simplify with dev_err_probe()
Message-ID: <20200902100247.GA4277@wunner.de>
References: <20200901153100.18827-1-krzk@kernel.org>
 <20200901153100.18827-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901153100.18827-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 01, 2020 at 05:31:00PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
