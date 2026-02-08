Return-Path: <linux-serial+bounces-12665-lists+linux-serial=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-serial@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILUmHZariGk4uAQAu9opvQ
	(envelope-from <linux-serial+bounces-12665-lists+linux-serial=lfdr.de@vger.kernel.org>)
	for <lists+linux-serial@lfdr.de>; Sun, 08 Feb 2026 16:28:22 +0100
X-Original-To: lists+linux-serial@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E2109288
	for <lists+linux-serial@lfdr.de>; Sun, 08 Feb 2026 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 993C33002D2E
	for <lists+linux-serial@lfdr.de>; Sun,  8 Feb 2026 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C63624B8;
	Sun,  8 Feb 2026 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CyGLUg8e"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B3535EDD8;
	Sun,  8 Feb 2026 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770564494; cv=none; b=Sjim/i6AHKz11w0xjX2IS9N1xalqkCngA2Q/rasoEOL4biqOwBc4+l7fHU5vJDCUvWWch3S4u+bqlvHlysXa/2VUPMF1LSvXu3MOo37amBURAlEFCNPcnSH2qfPcULptGNcB4l3+/TOJdvFMibFTLW8D1tAu2JgczPgOlKpxkfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770564494; c=relaxed/simple;
	bh=X8bBfTz3TiJJ9yTjYLymYOm2FxLu2G7EH2rrrTIT3Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl17+Y+xNtgO006BIP7deEXQFGOtPqUqK1I24eIHEYk1g/fXrX0z9GDU0HEhs2dEH8Z9Ijc5bcWzABCfeEh0CB9hYSNt7Vhb1fWUkDMpiAtWtHpNhN8k+fzXvalO2TCKYvThEETBD677MEgwI30/Wqt1r66/craukpugeSHFs9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CyGLUg8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313E5C4CEF7;
	Sun,  8 Feb 2026 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770564493;
	bh=X8bBfTz3TiJJ9yTjYLymYOm2FxLu2G7EH2rrrTIT3Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyGLUg8e1GEV3UI0HBoEJVEKdW3z1CJ76th2BUOJcYbsjTKdza/sMOjRLp8hoELY8
	 9WAcQXtvuIw7f29kTYYuzBR7IvoMpFcnLRnA7cy5+a3+EozKCNKnH+YyRf9Bi3Cyyv
	 Mc+zmoYVQRPzoXVwdSXy1W7YcGovaAzPyRJMS9iY=
Date: Sun, 8 Feb 2026 16:28:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] vt: add modifier support to cursor and navigation
 keys
Message-ID: <2026020851-bullhorn-glitch-0e37@gregkh>
References: <20260203045457.1049793-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203045457.1049793-1-nico@fluxnic.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12665-lists,linux-serial=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-serial@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-serial];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 861E2109288
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:52:45PM -0500, Nicolas Pitre wrote:
> This series adds xterm-style modifier encoding to cursor keys and navigation
> keys on the Linux console.
> 
> Modern terminal applications (shells, editors, TUI programs) rely on
> modifier+key combinations like Ctrl+Left, Shift+Home, or Alt+Delete for
> navigation and selection. The xterm protocol encodes these as CSI sequences
> with a modifier parameter (e.g., ESC [ 1 ; 5 D for Ctrl+Left).
> 
> While the existing func string table mechanism could technically support
> these sequences, each modifier combination would require a separate entry,
> quickly exhausting the limited string table space. This series instead
> generates the sequences programmatically, providing full modifier support
> without consuming string table entries.
> 
> This series addresses that in three patches:
> 
> 1. Add modifier encoding to cursor keys (Up/Down/Left/Right). When
> Shift, Alt, or Ctrl are held, the arrow keys now emit sequences like
> ESC [ 1 ; 2 A instead of plain ESC [ A.
> 
> 2. Add a new KT_CSI keysym type for navigation keys (Home, End, Insert,
> Delete, PgUp, PgDn) and function keys. These generate CSI tilde
> sequences (ESC [ n ~) with automatic modifier encoding.
> 
> 3. Add automatic fallback to the plain keymap for modifier-aware key
> types. This eliminates the need for explicit bindings for each
> modifier combination - a single plain keymap entry handles all
> modifier variants.
> 
> The modifier encoding follows the standard xterm convention:
>   mod = 1 + (shift ? 1 : 0) + (alt ? 2 : 0) + (ctrl ? 4 : 0)
> 
> Explicit keymap bindings take precedence, preserving backward
> compatibility with existing configurations.
> 
> Corresponding patches for the kbd package (loadkeys/dumpkeys) are ready
> and will be submitted once this kernel support is available.
> 
> diffstat:
>  drivers/tty/vt/keyboard.c     | 80 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/keyboard.h | 29 +++++++++++++
>  2 files changed, 103 insertions(+), 6 deletions(-)
> 
> 

Argh, sorry, I saw this patch series too late for this merge window.
I'll review it after -rc1 is out.

thanks,

greg k-h

