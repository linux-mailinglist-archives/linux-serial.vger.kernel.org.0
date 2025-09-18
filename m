Return-Path: <linux-serial+bounces-10768-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D8B57505
	for <lists+linux-serial@lfdr.de>; Mon, 15 Sep 2025 11:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E7E3BE7D2
	for <lists+linux-serial@lfdr.de>; Mon, 15 Sep 2025 09:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FEC2F8BC1;
	Mon, 15 Sep 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFnuMmDr"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FB2F8BE6
	for <linux-serial@vger.kernel.org>; Mon, 15 Sep 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929186; cv=none; b=CqKOAPkGfI6k2CBmbcxiyXYDg3Y5bx0dHKYzOJ/kX/ksPSdU1B+DvIjMFASFiRs+lnSC3SMdEfEJ1KCPAC/k75/5+ET+vPozer1KuVQzZwhbCXcNHr9G3SWBhUWdYghH36vLNXQReV87xDvrFBXo9ZkqQtcKMhVGgsKWOo+ldjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929186; c=relaxed/simple;
	bh=rLFJRG9raI9R5ZSmQyhmfgNEveNgusoJOK1TuQI/TpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E0ZqoiaQJPBUFm2xuE6GbRc3Vye6HN1DkpjCNj01EdUR+kc5TCqoFRL6XYlToHNh481zOfuAaahV+b+enUsbkBGdcOEHW3Z9mCp2oobg4Z1ziVOsoiP7N0z/qoDwRy51TbO4LVrAf3OopEceM5OcCL4Kk23czNZrEE6i3RWJ7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aFnuMmDr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso16006855e9.2
        for <linux-serial@vger.kernel.org>; Mon, 15 Sep 2025 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757929182; x=1758533982; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeBNoqwiRyTpHccFN0RYy9HMwB73BnSA3X0nN71V0/0=;
        b=aFnuMmDrYoHXsQnN6KIP7K495nyt3p8zKJpU6mK89BHaMjzQqeascEdoFgd3N8jwEL
         cF7X5LKE+xYpg1CM1s79L0kkXFvd9kRLQiH1pMmnbsENZbq12nOoaK0n0WA7mBf2IMZZ
         0ccwCvWRd7mLHdJ4VVMA6tsD8y8Jo6UfC9sLNHDJ2m4UmjEGAluo9OVt/45Yz5Sx6la0
         kmWx7o28IEDY8Gn18LPYg8QYJhPPCzp/kWFRZdrHSOMVxPHb4NwvIM4ohWDZCrLMqYvH
         lGTkbgWqPfYQdfiy76SEsSDU8TkBCK+4zXkGBzEJ/K0UwMZw+NrQ6+0Tw8gq73B8SV+o
         kK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757929182; x=1758533982;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QeBNoqwiRyTpHccFN0RYy9HMwB73BnSA3X0nN71V0/0=;
        b=rzn+jB6kuv1oEjevoDQnhtKf49/jrICK+29XKFMAftmy3KBcLzinlh6FJokMgmEVw3
         Ea5PFL7GNrB/FY+9kaGLkUy0NPD+bmwMzO+kb3j5BaGW90Ftj+Ulahi54hw3IG1Rx0h9
         Wv8MTatsUJeB5kaNL4g79qeZ5Z1Q5jYTNCGgCBOQsZfMapXCwTTcXYFn2OMxnER1WH3j
         e8sTyquHMqEyi3Cg0IPCQbQaQSNjoIvlYVTSP8H7jjMFWGOrG9bds6cyz+pjpPQn1/p6
         Hk9XIKMJ8rleYhZ+uOQWPw8g0P7ewZR5ljh18ygC0WmwmXkA8tpOduH5hjT3HHPcnVNL
         XSng==
X-Forwarded-Encrypted: i=1; AJvYcCVxuSexENRAHsNoQ2L8i4I2jorZziLNo70wc0vjvYb5KhWrzSvs3nhITLGAgscifPsXRy5Rm8Kw2oPcYk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1T8yKFS0clpI+1zgQC6QzUFUxRUZDNc0q6EHyvpA65MR814Ur
	0yicHWe7ZyGb9FKl9YG+z0k9PSOXwKOSH1HQHS6Q4ehGDe1JDaH3/g4j22KlsBKdFBI=
X-Gm-Gg: ASbGnctDAOgiLykYxWxrhJIcda6hV8t3JP33mdfvydVqjkXSkTzbErBSDWzAwn3/8ha
	7fCdK/QeuAekHNEzwLzLo8Z4XcvotqSEwe+3oh5YsOP/df5B8hTNH+TKpklkJ8EsjBnLGHZppaI
	QGHhvQmAS2VCtyQwiHZJe4nsRvtjlLaWWAcpPBtxNMZLw4nPP38EwbnknqKGhqQLBjSt++TD378
	7qdth1DvMTm46MTnv+FibDDkXSbmWQrPTZOcDAoTJ1F9pptoK1iShHoZEg03NtqveOhVFQP2WuP
	0lk5lDZqQuBR7giizBqOQ55O6ZhtM/oYc3pUB5pxDYYXCU7uKeuDnU8p6Le2r6I/72QeY4bjMt6
	3qm4BByKOLyEBZ5SeCBVj7T5bbvg=
X-Google-Smtp-Source: AGHT+IE2F00YttfvBqUggbVpYmki5C8laTbOePF+mrqdJF7EUUCAKuMMZrRyuKp3HVj45rNTjX3vJQ==
X-Received: by 2002:a05:600c:46ca:b0:458:a992:6f1e with SMTP id 5b1f17b1804b1-45f211c4c8bmr139781445e9.5.1757929181960;
        Mon, 15 Sep 2025 02:39:41 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:e60f:4b6c:1734:808b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607878c9sm17109021f8f.26.2025.09.15.02.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 02:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Sep 2025 10:39:40 +0100
Message-Id: <DCT9VWQYD4VM.1NV5FJJCJG4PI@linaro.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, <psodagud@quicinc.com>,
 <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
 <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
 <quic_shazhuss@quicinc.com>, <krzk@kernel.org>
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>, "Praveen Talari"
 <quic_ptalari@quicinc.com>
X-Mailer: aerc 0.20.0
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
 <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
 <2c5fd01a-543b-4108-ac54-80d1d87b65a3@oss.qualcomm.com>
In-Reply-To: <2c5fd01a-543b-4108-ac54-80d1d87b65a3@oss.qualcomm.com>

(removing <quic_mnaresh@quicinc.com> from c/c -- too many mail not delivere=
d)

Hi Praveen,

On Mon Sep 15, 2025 at 7:58 AM BST, Praveen Talari wrote:
> Hi Alexey,
>
> Really appreciate you waiting!
>
> On 9/11/2025 2:30 PM, Alexey Klimov wrote:
>> Hi Praveen,
>>=20
>> On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
>>> Hi Alexy,
>>>
>>> Thank you for update.
>>>
>>> On 9/10/2025 1:35 AM, Alexey Klimov wrote:
>>>>
>>>> (adding Krzysztof to c/c)
>>>>
>>>> On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
>>>>> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
>>>>>> A deadlock is observed in the qcom_geni_serial driver during runtime
>>>>>> resume. This occurs when the pinctrl subsystem reconfigures device p=
ins
>>>>>> via msm_pinmux_set_mux() while the serial device's interrupt is an
>>>>>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
>>>>>> __synchronize_irq(), conflicting with the active wakeup state and
>>>>>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
>>>>>> leading to system instability.
>>>>>>
>>>>>> The critical call trace leading to the deadlock is:
>>>>>>
>>>>>>       Call trace:
>>>>>>       __switch_to+0xe0/0x120
>>>>>>       __schedule+0x39c/0x978
>>>>>>       schedule+0x5c/0xf8
>>>>>>       __synchronize_irq+0x88/0xb4
>>>>>>       disable_irq+0x3c/0x4c
>>>>>>       msm_pinmux_set_mux+0x508/0x644
>>>>>>       pinmux_enable_setting+0x190/0x2dc
>>>>>>       pinctrl_commit_state+0x13c/0x208
>>>>>>       pinctrl_pm_select_default_state+0x4c/0xa4
>>>>>>       geni_se_resources_on+0xe8/0x154
>>>>>>       qcom_geni_serial_runtime_resume+0x4c/0x88
>>>>>>       pm_generic_runtime_resume+0x2c/0x44
>>>>>>       __genpd_runtime_resume+0x30/0x80
>>>>>>       genpd_runtime_resume+0x114/0x29c
>>>>>>       __rpm_callback+0x48/0x1d8
>>>>>>       rpm_callback+0x6c/0x78
>>>>>>       rpm_resume+0x530/0x750
>>>>>>       __pm_runtime_resume+0x50/0x94
>>>>>>       handle_threaded_wake_irq+0x30/0x94
>>>>>>       irq_thread_fn+0x2c/xa8
>>>>>>       irq_thread+0x160/x248
>>>>>>       kthread+0x110/x114
>>>>>>       ret_from_fork+0x10/x20
>>>>>>
>>>>>> To resolve this, explicitly manage the wakeup IRQ state within the
>>>>>> runtime suspend/resume callbacks. In the runtime resume callback, ca=
ll
>>>>>> disable_irq_wake() before enabling resources. This preemptively
>>>>>> removes the "wakeup" capability from the IRQ, allowing subsequent
>>>>>> interrupt management calls to proceed without conflict. An error pat=
h
>>>>>> re-enables the wakeup IRQ if resource enablement fails.
>>>>>>
>>>>>> Conversely, in runtime suspend, call enable_irq_wake() after resourc=
es
>>>>>> are disabled. This ensures the interrupt is configured as a wakeup
>>>>>> source only once the device has fully entered its low-power state. A=
n
>>>>>> error path handles disabling the wakeup IRQ if the suspend operation
>>>>>> fails.
>>>>>>
>>>>>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for seria=
l driver")
>>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>>
>>>>> You forgot:
>>>>>
>>>>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>>>>>
>>>>> Also, not sure where this change will go, via Greg or Jiri, but ideal=
ly
>>>>> this should be picked for current -rc cycle since regression is
>>>>> introduced during latest merge window.
>>>>>
>>>>> I also would like to test it on qrb2210 rb1 where this regression is
>>>>> reproduciable.
>>>>
>>>> It doesn't seem that it fixes the regression on RB1 board:
>>>>
>>>>    INFO: task kworker/u16:3:50 blocked for more than 120 seconds.
>>>>          Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
>>>>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this me=
ssage.
>>>>    task:kworker/u16:3   state:D stack:0     pid:50    tgid:50    ppid:=
2      task_flags:0x4208060 flags:0x00000010
>>>>    Workqueue: async async_run_entry_fn
>>>>    Call trace:
>>>>     __switch_to+0xf0/0x1c0 (T)
>>>>     __schedule+0x358/0x99c
>>>>     schedule+0x34/0x11c
>>>>     rpm_resume+0x17c/0x6a0
>>>>     rpm_resume+0x2c4/0x6a0
>>>>     rpm_resume+0x2c4/0x6a0
>>>>     rpm_resume+0x2c4/0x6a0
>>>>     __pm_runtime_resume+0x50/0x9c
>>>>     __driver_probe_device+0x58/0x120
>>>>     driver_probe_device+0x3c/0x154
>>>>     __driver_attach_async_helper+0x4c/0xc0
>>>>     async_run_entry_fn+0x34/0xe0
>>>>     process_one_work+0x148/0x284
>>>>     worker_thread+0x2c4/0x3e0
>>>>     kthread+0x12c/0x210
>>>>     ret_from_fork+0x10/0x20
>>>>    INFO: task irq/92-4a8c000.:79 blocked for more than 120 seconds.
>>>>          Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
>>>>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this me=
ssage.
>>>>    task:irq/92-4a8c000. state:D stack:0     pid:79    tgid:79    ppid:=
2      task_flags:0x208040 flags:0x00000010
>>>>    Call trace:
>>>>     __switch_to+0xf0/0x1c0 (T)
>>>>     __schedule+0x358/0x99c
>>>>     schedule+0x34/0x11c
>>>>     __synchronize_irq+0x90/0xcc
>>>>     disable_irq+0x3c/0x4c
>>>>     msm_pinmux_set_mux+0x3b4/0x45c
>>>>     pinmux_enable_setting+0x1fc/0x2d8
>>>>     pinctrl_commit_state+0xa0/0x260
>>>>     pinctrl_pm_select_default_state+0x4c/0xa0
>>>>     geni_se_resources_on+0xe8/0x154
>>>>     geni_serial_resource_state+0x8c/0xbc
>>>>     qcom_geni_serial_runtime_resume+0x3c/0x88
>>>>     pm_generic_runtime_resume+0x2c/0x44
>>>>     __rpm_callback+0x48/0x1e0
>>>>     rpm_callback+0x74/0x80
>>>>     rpm_resume+0x3bc/0x6a0
>>>>     __pm_runtime_resume+0x50/0x9c
>>>>     handle_threaded_wake_irq+0x30/0x80
>>>>     irq_thread_fn+0x2c/0xb0
>>>>     irq_thread+0x170/0x334
>>>>     kthread+0x12c/0x210
>>>>     ret_from_fork+0x10/0x20
>>>
>>> I can see call stack is mostly similar for yours and mine but not
>>> completely at initial calls.
>>>
>>> Yours dump:
>>>   >    qcom_geni_serial_runtime_resume+0x3c/0x88
>>>   >    pm_generic_runtime_resume+0x2c/0x44
>>>   >    __rpm_callback+0x48/0x1e0
>>>   >    rpm_callback+0x74/0x80
>>>   >    rpm_resume+0x3bc/0x6a0
>>>   >    __pm_runtime_resume+0x50/0x9c
>>>   >    handle_threaded_wake_irq+0x30/0x80
>>>
>>> Mine:
>>>   >>>      qcom_geni_serial_runtime_resume+0x4c/0x88
>>>   >>>      pm_generic_runtime_resume+0x2c/0x44
>>>   >>>      __genpd_runtime_resume+0x30/0x80
>>>   >>>      genpd_runtime_resume+0x114/0x29c
>>>   >>>      __rpm_callback+0x48/0x1d8
>>>   >>>      rpm_callback+0x6c/0x78
>>>   >>>      rpm_resume+0x530/0x750
>>>
>>>
>>> Can you please share what is DT file for this Board if possible?
>>> is there any usecase enabled on this SE instance?
>>=20
>> Well, yeah, sorry, I didn't really compared backtraces line to line and
>> behaviour was exactly the same. I thought that the purpose was to fix
>> the regression reported earlier.
>>=20
>> RB1 main dts files are qrb2210-rb1.dts and qcm2290.dtsi.
>>=20
>> The similar board RB2 uses qrb4210-rb2.dts and sm4250.dtsi+sm6115.dtsi,
>> it is worth checking it as well.
>> For testing here I didn't use anything extra (the only change was wifi f=
ix
>> from Loic); I tested -master and linux-next usually.
>>=20
>> If you can tell me what is SE instance I may be able to answer. But
>> as far as I know it is not a part of any infrastructure or CI machinery.
>> I just boot the board and see if it works, if it does then I rebuild and
>> test my changes (audio).
>
> I'm actively working on this and experimenting various scenarios with=20
> wakeup. I=E2=80=99ll share the updated patch as soon as possible.
>
> Should we include fix in V2 or new version(V1) if the fix originates=20
> from a different subsystem(pinctrol)?

Wait, I am a bit lost. Are there two regresssions? And is this patch only
targets one of the them?
Are there two fixes now for different problems?
If they are not related (independent) then I'd split it but it not somethin=
g
exceptional -- just standard rules should apply.

Thanks,
Alexey

