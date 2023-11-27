Return-Path: <linux-serial+bounces-254-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C67FAA01
	for <lists+linux-serial@lfdr.de>; Mon, 27 Nov 2023 20:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689C92819D2
	for <lists+linux-serial@lfdr.de>; Mon, 27 Nov 2023 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6E3E490;
	Mon, 27 Nov 2023 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-serial@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA013D5F;
	Mon, 27 Nov 2023 11:14:31 -0800 (PST)
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id BEC0A206D2;
	Mon, 27 Nov 2023 20:14:29 +0100 (CET)
From: Francesco Dolcini <francesco@dolcini.it>
To: Sean Wang <sean.wang@mediatek.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 0/3] Bluetooth: fix recv_buf() return value
Date: Mon, 27 Nov 2023 20:14:05 +0100
Message-Id: <20231127191409.151254-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Serdev recv_buf() callback is supposed to return the amount of bytes consumed, therefore an int in between 0 and count.

Do not return negative number in case of issue, just print an error and return count. This fixes a WARN in ttyport_receive_buf().

In addition to that a small cleanup patch is added on btnxpuart to remove a useless assignment.

Francesco Dolcini (3):
  Bluetooth: btnxpuart: fix recv_buf() return value
  Bluetooth: btmtkuart: fix recv_buf() return value
  Bluetooth: btnxpuart: remove useless assignment

 drivers/bluetooth/btmtkuart.c | 11 +++--------
 drivers/bluetooth/btnxpuart.c |  8 +++-----
 2 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.25.1


