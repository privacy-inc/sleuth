import XCTest
@testable import Sleuth

final class BlockTests: XCTestCase {
    private var router: Router!
    private let list =  [
        "https://sourcepoint.theguardian.com/index.html?message_id=343252&consentUUID=4debba32-1827-4286-b168-cd0a6068f5f5&requestUUID=0a3ee8d3-cc2e-43b1-99ba-ceb02302f3e5&preload_message=true)",
        "https://tags.crwdcntrl.net/lt/shared/1/lt.iframe.html",
        "https://elb.the-ozone-project.com/static/load-cookie.html?gdpr=1&gdpr_consent=CO7HiBtO7HiBtAGABCENA7CgAP_AAEfAAAYgGStT_S9fb2-je_59d9t0eY1f9763tewjhgeMs-4NwRuW_J4WrmMyvB34JqAKGAgEujJBAQdlGGDcBQgAgIkFgTLMYk2MiwNKJpJEClIbM2dYGC1PnUVDuQCY7E--Pvrzvl-6-3__YGSEAGAAKAQACGAgIEChUIAEIQxIAAAACggAAoEgAAAgQLIoCOEAAABAYAIAAAAAggAIBAAIAAEBAAAAAAIAAARAIAAQACAEAAAAAEEABIgAAACAEhAAAAAKAAAUAAAIAgAAAAAZ3QDxkAsAFQATABHADLAGoAPwAjACYgE2ALRAWwNABABmAY8IgJAAqACSAFYAZYA1ABsgD8AIwAUsA1gB8gENgIvASIAmwBOwCkQFyBIFQACwAKgAZAA4AB4AEAAKgAYABEACSAEyAKoArABYADeAHOARABEgCaAFKAMMAZcA1ADVAGyAPiAfYB-gEYAMUAawA2gBuAD5AIbARUAi8BIgCYgEygJsATsApEBYoC2AFyBQAYARwGMgMeDQEwAVABJACsAMsAagA2QB-AEYAKWAawA-QCGwEXgJEATYAnYBSIC5AGMCoCAAKgAmACOAGWANQAfgBGACOAFLASCAmIBNgC2AFyALzAZEOgSgALAAqABkADgAIIAYABiAD4AIgATIAqgCsAFgAMQAbwA5gCIAE0AKUAagA2QBvwD7APwAjABcwC8gGKANwAdMBDYCIgEXgJBASIAmwBOwCxYFsAWyAuQeAFACOAioBjMDHAMdAZEQgJgALAAyADEAJgAVQA3gCOAGoAN8AfgBGADFAJBASIAmwBYoC0YFsAWyAuQiABAY8SgLAALAAyAByAGAAYgBEACYAFUAMQAbYBEAESAKUAaoA2QB-AEYAMUAbgBF4CRAE2ALFAWwTACABHARUAxkBjxSA6AAsACoAGQAOAAggBgAGIARAAmABSACqAFgAMQAcwBEAClAGqANmAfYB-AEYALyAbQA3ACLwEiAJsATsAsUBbAC5CoAUAHwARwGMgMeAZAA.YAAAAAAAAAAA&pubcid=8d865511-91a7-4b5a-bc49-e15dbdce494c&publisherId=OZONEGMG0001&siteId=4204204209&cb=1602421568472",
        "https://ads.pubmatic.com/AdServer/js/showad.js#PIX&kdntuid=1&p=157207&gdpr=1&gdpr_consent=CO7HiBtO7HiBtAGABCENA7CgAP_AAEfAAAYgGStT_S9fb2-je_59d9t0eY1f9763tewjhgeMs-4NwRuW_J4WrmMyvB34JqAKGAgEujJBAQdlGGDcBQgAgIkFgTLMYk2MiwNKJpJEClIbM2dYGC1PnUVDuQCY7E--Pvrzvl-6-3__YGSEAGAAKAQACGAgIEChUIAEIQxIAAAACggAAoEgAAAgQLIoCOEAAABAYAIAAAAAggAIBAAIAAEBAAAAAAIAAARAIAAQACAEAAAAAEEABIgAAACAEhAAAAAKAAAUAAAIAgAAAAAZ3QDxkAsAFQATABHADLAGoAPwAjACYgE2ALRAWwNABABmAY8IgJAAqACSAFYAZYA1ABsgD8AIwAUsA1gB8gENgIvASIAmwBOwCkQFyBIFQACwAKgAZAA4AB4AEAAKgAYABEACSAEyAKoArABYADeAHOARABEgCaAFKAMMAZcA1ADVAGyAPiAfYB-gEYAMUAawA2gBuAD5AIbARUAi8BIgCYgEygJsATsApEBYoC2AFyBQAYARwGMgMeDQEwAVABJACsAMsAagA2QB-AEYAKWAawA-QCGwEXgJEATYAnYBSIC5AGMCoCAAKgAmACOAGWANQAfgBGACOAFLASCAmIBNgC2AFyALzAZEOgSgALAAqABkADgAIIAYABiAD4AIgATIAqgCsAFgAMQAbwA5gCIAE0AKUAagA2QBvwD7APwAjABcwC8gGKANwAdMBDYCIgEXgJBASIAmwBOwCxYFsAWyAuQeAFACOAioBjMDHAMdAZEQgJgALAAyADEAJgAVQA3gCOAGoAN8AfgBGADFAJBASIAmwBYoC0YFsAWyAuQiABAY8SgLAALAAyAByAGAAYgBEACYAFUAMQAbYBEAESAKUAaoA2QB-AEYAMUAbgBF4CRAE2ALFAWwTACABHARUAxkBjxSA6AAsACoAGQAOAAggBgAGIARAAmABSACqAFgAMQAcwBEAClAGqANmAfYB-AEYALyAbQA3ACLwEiAJsATsAsUBbAC5CoAUAHwARwGMgMeAZAA.YAAAAAAAAAAA",
        "https://js-sec.indexww.com/um/ixmatch.html",
        "https://ssum-sec.casalemedia.com/usermatch?gdpr=1&gdpr_consent=CO7HiBtO7HiBtAGABCENA7CgAP_AAEfAAAYgGStT_S9fb2-je_59d9t0eY1f9763tewjhgeMs-4NwRuW_J4WrmMyvB34JqAKGAgEujJBAQdlGGDcBQgAgIkFgTLMYk2MiwNKJpJEClIbM2dYGC1PnUVDuQCY7E--Pvrzvl-6-3__YGSEAGAAKAQACGAgIEChUIAEIQxIAAAACggAAoEgAAAgQLIoCOEAAABAYAIAAAAAggAIBAAIAAEBAAAAAAIAAARAIAAQACAEAAAAAEEABIgAAACAEhAAAAAKAAAUAAAIAgAAAAAZ3QDxkAsAFQATABHADLAGoAPwAjACYgE2ALRAWwNABABmAY8IgJAAqACSAFYAZYA1ABsgD8AIwAUsA1gB8gENgIvASIAmwBOwCkQFyBIFQACwAKgAZAA4AB4AEAAKgAYABEACSAEyAKoArABYADeAHOARABEgCaAFKAMMAZcA1ADVAGyAPiAfYB-gEYAMUAawA2gBuAD5AIbARUAi8BIgCYgEygJsATsApEBYoC2AFyBQAYARwGMgMeDQEwAVABJACsAMsAagA2QB-AEYAKWAawA-QCGwEXgJEATYAnYBSIC5AGMCoCAAKgAmACOAGWANQAfgBGACOAFLASCAmIBNgC2AFyALzAZEOgSgALAAqABkADgAIIAYABiAD4AIgATIAqgCsAFgAMQAbwA5gCIAE0AKUAagA2QBvwD7APwAjABcwC8gGKANwAdMBDYCIgEXgJBASIAmwBOwCxYFsAWyAuQeAFACOAioBjMDHAMdAZEQgJgALAAyADEAJgAVQA3gCOAGoAN8AfgBGADFAJBASIAmwBYoC0YFsAWyAuQiABAY8SgLAALAAyAByAGAAYgBEACYAFUAMQAbYBEAESAKUAaoA2QB-AEYAMUAbgBF4CRAE2ALFAWwTACABHARUAxkBjxSA6AAsACoAGQAOAAggBgAGIARAAmABSACqAFgAMQAcwBEAClAGqANmAfYB-AEYALyAbQA3ACLwEiAJsATsAsUBbAC5CoAUAHwARwGMgMeAZAA.YAAAAAAAAAAA&s=184674&cb=https%3A%2F%2Fjs-sec.indexww.com%2Fht%2Fhtw-pixel.gif%3F",
        "https://tpc.googlesyndication.com/safeframe/1-0-37/html/container.html",
        "https://c219afb78bb1f379b2758d73666870e6.safeframe.googlesyndication.com/safeframe/1-0-37/html/container.html",
        "https://vars.hotjar.com/box-469cf41adb11dc78be68c1ae7f9457a4.html",
        "https://reuters.demdex.net/dest5.html?d_nsid=0#https%3A%2F%2Fuk.reuters.com",
        "https://mafo.adalliance.io/",
        "https://ad.yieldlab.net/d/7053789/631/2x2?ts=0.32566239883440873&type=h&consent=CO7HjPDO7HjPDAGABCDEA7CgAP_AAAFAAAYgGQAR5CoUTGFAUXB4QtkAGYQQUAQEAWAAAACAAiABAAEAMAAAAUAAoASAAAACAAAAIAIBAAAACAAEAQAAQAAEAAAAAAAAgAAIIABEAAAAAAAAAAgAAAAAAAAAAAEBAAAAkAAAAmIEC2oAQAcgFtAHjIAgATAAuAEcAXmIgDABcAEMAhsBF4CRAFDhIDgACwAKgAZAA8ACAAGgAPAAiABMAC4AG8AOYAhABDAClAGGANUAfoBGgCOAGKANwAegBDYCLwEiAKHAXmEAAgBPDQBgAuACGAQ2Ai8BIgChwwAEA6gqAIAEwALgBHAF5joDoACwAKgAZABAADQAHgAPgAiABMAC4AGIAN4AcwBCACGAEwAKUAaIA_QCOAGKANwAdQA9ACGwEXgJEAUOAvMcAHACeAF8AiwBdQDAgGvARAQgFgALAAyAEwALgAYgA3gEcAMUAdQA9ACRCAAIAL4BdSUBIABYAGQAeABEACYAFwAMQAhABDAClAGqARwAxQBuADqAIvASIAvMkADAC-AXUA15SAwAAsACoAGQAQAA0AB4AEQAJgAXAAxABzAEIAIYAUoA0QBqgD9AI4AbgA9ACLwEiAKHAXmUADABPAC-ARYAuoBigDXg.YAAAAAAAAAAA",
        "https://spiegel.demdex.net/dest5.html?d_nsid=0#https%3A%2F%2Fwww.spiegel.de",
        "https://widgets.sparwelt.click/widget?widget_id=23789",
        "https://adstax-match.adrtx.net/activation?receiverId=adaud",
        "https://gum.criteo.com/syncframe?topUrl=www.spiegel.de&gdpr_consent=CO61zsyO61zsyAGABCDEA6CgAP_AAAFAAAYgGQAR5CoUTGFAUXB4QtkAGYQQUAQEAWAAAACAAiABAAEAMAAAAUAAoASAAAACAAAAIAIBAAAACAAEAQAAQAAEAAAAAAAAgAAIIABEAAAAAAAAAAgAAAAAAAAAAAEBAAAAkAAAAmIEC2oAQAcgFtAHjIAgATAAuAEcAXmIgDgAXAC4AIYBDYCLwEiAKHCQHAAFgAVAAuABkADwAIAAaAA8ACIAEwALgAbwA5gCEAEMAKUAYYA_QCNAEcAMUAbgA9ACGwEXgJEAUOAvMIACACeAokNAHAAuAFwAQwCGwEXgJEAUOGAAgHUFQBAAmABcAI4AvMdAeAAWABUAC4AGQAQAA0AB4AD4AIgATAAuABiADeAHMAQgAhgBMAClAGiAP0AjgBigDcAHUAPQAhsBF4CRAFDgLzHACAAngBfAIsARoAuoBgQDXgIgIQCwAFgAZACYAFwAMQAbwCOAGKAOoAegBIhAAEAF8AupKAkAAsAC4AGQAeABEACYAFwAMQAhABDAClAI4AYoA3AB1AEXgJEAXmSABgBfALqAa8pAYAAWABUAC4AGQAQAA0AB4AEQAJgAXAAxABzAEIAIYAUoA0QB-gEcANwAegBF4CRAFDgLzKABgAngBfAIsAXUAxQBrwAA.YAAAAAAAAAAA#%7B%22optout%22:%7B%22value%22:false,%22origin%22:0%7D,%22uid%22:%7B%22origin%22:0%7D,%22sid%22:%7B%22origin%22:0%7D,%22origin%22:%22publishertag%22,%22version%22:98,%22lwid%22:%7B%22origin%22:0%7D,%22tld%22:%22spiegel.de%22,%22bundle%22:%7B%22origin%22:0%7D,%22topUrl%22:%22www.spiegel.de%22,%22cw%22:true%7D",
        "https://interactive.spiegel.de/int/pub/common/img/pixel.gif",
        "https://datawrapper.dwcdn.net/IoE9j/223/",
        "https://googleads.g.doubleclick.net/pagead/render_post_ads_v1.html#exk=1306804804&a_pr=11:TPeIK7Weg7.lb3KjNhYf7fSugAMSGF693F5KAw",
        "https://imagesrv.adition.com/banners/268/00/b3/65/06/index.html?clicktag=https%3A%2F%2Fde7.splicky.com%2Fclk%3Fmid%3D8805366030483347127%26aid%3D406208%26url%3Dhttps%3A%2F%2Fad4.adfarm1.adition.com%2Fredi%3Flid%3D6882352274847564137%26gdpr%3D0%26gdpr%5Fconsent%3D%26gdpr%5Fpd%3D0%26userid%3D6882352274847433065%26sid%3D4573083%26kid%3D3887752%26bid%3D11773239%26c%3D23805%26keyword%3D%255Bu%255Dtheguardian.com%255BIDFA%255D%255BAAID%255D%26sr%3D0%26clickurl%3Dhttps%3A%2F%2Fad2.adfarm1.adition.com%2Fredi%3Flid%3D6882352274857395416%26gdpr%3D0%26gdpr%5Fconsent%3D%26gdpr%5Fpd%3D0%26userid%3D6882352274857264344%26sid%3D4534627%26kid%3D3865979%26bid%3D11756806%26c%3D13762%26keyword%3DPACS%255F4573083%255F11773239%26sr%3D0%26clickurl%3D&gdpr=0&gdpr_consent=&h5Params=%7B%7D",
        "https://us-u.openx.net/w/1.0/pd?cc=1&plm=10&ph=bbb82fae-1d27-4d90-bb10-e24164ecd7bc",
        "https://interactive.guim.co.uk/uploader/embed/2020/09/archive-3-zip/giv-3902xoR671UFuHsK/",
        "https://www.googleadservices.com/pagead/aclk?sa=L&ai=CLGUYOgmDX_nYCJ6X3gOM1ZLIA5eSusRfnvKlk-4L6oywtOgOEAEgvJbhEGCV-vCBjAegAfyLlJkDyAEJqQKBfdTrMdezPuACAKgDAcgDCqoEhwJP0Hm0OWQjz_4hTx4y0D1nPtIFf3PVwEOxv-V2umIiqwqE5hRf0Q_1m571JayrTsETuW4XPeC28aLdv2I6EQ3mIRUa8ckR5xJBWTvNBTqotBvYNDhaVTwu9dG2pcZg_FLHsUiKT5w649rB2476XvLoxiFkJqWUrx2hzDjMlp8zGx0PtcQNTU5wgy6u-OaRvc0LUFo-r90wWjAwtXbBA0yS0nJiUzpqCrLbPUeXJrv3dmBcngmQDfRVRRwFKKEXo1eSMXsh_mEXQg2BQSXtdjGwu1aXdsa4bSUn20Brwovrzt5oZd6N1W4xYZak98w-YXwkMsPP7VL1Yeyt7iTf4IJPoiiYi_d7VsAEivLc-IkD4AQBiAXc7N2pJ6AGLtgGAoAH7PPrZqgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcAoAiMhqkEsAgC0ggJCIDhgFAQARgdsQkoheo0SI0_QYAKA5gLAcgLAYAMAdgTDIIUFRoTd3d3LnRoZWd1YXJkaWFuLmNvbQ&num=1&cid=CAASPeRoRf5K8aIm1K7aLPaj00RNvviOn1VMnv-Y3i2rXsRp4bfbGaYQZ34ywrAINz0op0HxF-Cv9NyR9M77K30&sig=AOD64_395HuIOkm6CGxGyO0b4nhzEuv9Rw&client=ca-pub-2012933198307164&nb=9&nx=186&ny=128&adurl=https://www.aroundhome.de/solaranlage/formular/%3Futm_source%3Dgoogle%26utm_medium%3Ddis_gdn%26prid%3D30%26meco%3Dde%26utm_id%3Dga_655-575-7282_10556503644_105748314378_448627240777%26vendor_id%3Dga%26account_id%3D655-575-7282%26ad_mt%3D%26ad_mo%3Dmobile%26ad_pm%3Dwww.theguardian.com%26ad_pos%3Dnone%26campaign_id%3D10556503644%26adgroup_id%3D105748314378%26ad_id%3D448627240777%26click_id%3D%7Bgclid%7D%26ad_kw%3D%26ad_nw%3Dd%26ad_dev%3Dm%26ad_devmod%3Dapple%252Biphone%26utm_campaign%3D10556503644%26utm_term%3D%26utm_content%3D448627240777",
        "https://www.dianomi.com/smartads.epl?id=4651",
        "https://platform.twitter.com/widgets/widget_iframe.96fd96193cc66c3e11d4c5e4c7c7ec97.html?origin=https%3A%2F%2Fgraphics.thomsonreuters.com",
        "https://imasdk.googleapis.com/js/core/bridge3.416.2_en_gb.html#goog_1018570912",
        "https://s7.addthis.com/static/sh.f48a1a04fe8dbf021b4cda1d.html#rand=0.7766023683085544&iit=1602423520070&tmr=load%3D1602423519912%26core%3D1602423519932%26main%3D1602423520069%26ifr%3D1602423520072&cb=0&cdn=0&md=0&kw=Arizona%2CUnited%20States%2CStephanie%20Keith%2CLiving%20Planet%2CClimate%20Change%2CWater%2CEnvironment%2CEarth%2CNature%2CRain%2CDrought%2CU.S.%20Politics%2CTrump%2CElections&ab=-&dh=widerimage.reuters.com&dr=&du=https%3A%2F%2Fwiderimage.reuters.com%2Fstory%2Fclimate-change-is-drying-the-lifeblood-of-navajo-ranchers-as-their-lands-become-desert%3Futm_campaign%3Dweb-app-launch%26utm_medium%3Dbanner%26utm_source%3Drcom%26utm_content%3Dros&href=https%3A%2F%2Fwiderimage.reuters.com%2Fstory%2Fclimate-change-is-drying-the-lifeblood-of-navajo-ranchers-as-their-lands-become-desert&dt=Climate%20change%20is%20drying%20the%20lifeblood%20of%20Navajo%20ranchers%20as%20their%20lands%20become%20desert&dbg=0&cap=tc%3D0%26ab%3D0&inst=1&jsl=131073&prod=undefined&lng=en&ogt=locality%2Cdescription%2Cheight%2Cwidth%2Cimage%2Ctitle%2Ctype%3Darticle&pc=men&pub=ra-54e32b736b5ad1fe&ssl=1&sid=5f830adfaa5c76b3&srf=0.01&ver=300&xck=0&xtr=0&og=site_name%3DThe%2520Wider%2520Image%26url%3Dhttps%253A%252F%252Fwiderimage.reuters.com%252Fstory%252Fclimate-change-is-drying-the-lifeblood-of-navajo-ranchers-as-their-lands-become-desert%26type%3Darticle%26title%3DClimate%2520change%2520is%2520drying%2520the%2520lifeblood%2520of%2520Navajo%2520ranchers%2520as%2520their%2520lands%2520become%2520desert%26image%3Dhttps%253A%252F%252Fphotos.wi.gcs.trstatic.net%252FWBTnOVC7qqta06gXHeKsQ3ZxuCfZIeTKXD8EoWVvw-ZPwxZjmpgR3xpmatdKPO1Er1DxMAMuzV-pFFsihtnzico8ZcMeCfsV0hURQJZtKgKDwqgZAaRA8eh6xWipOXCY%26width%3D768%26height%3D512%26description%3DTwo%2520decades%2520into%2520a%2520severe%2520drought%2520on%2520the%2520Navajo%2520reservation%252C%2520the%2520open%2520range%2520around%2520Maybelle%2520Sloan%25E2%2580%2599s%2520sheep%2520farm%2520stretches%2520out%2520in%2520a%2520brown%2520expanse%2520of%2520earth%2520and%2520sagebrush.%26locality%3DArizona&csi=undefined&rev=v8.28.7-wp&ct=0&xld=1&xd=1",
        "https://static.emsservice.de/werbemittel/ejp/Eurojackpot_1577722552/EJP_19-11_SPON-Ads_Responsive-Billboard/index.html",
        "https://aax-eu.amazon-adsystem.com/s/iu3?cm3ppd=1&d=dtb-pub&csif=t&dl=n-emx&dcc=t",
        "https://secure-assets.rubiconproject.com/utils/xapi/multi-sync.html?p=19564_2&endpoint=us-east&gdpr=1&gdpr_consent=CO7Hn9TO7HoCpASABCENA6CsAP_AAG_AAAYgGxwIAAAgAKgAYABoAEgAOQAgACEAGgAOgAfABFgCYAJoATwApABbAC_AGEAYgAzAB4AD8AIAAQkAjgCPgFIAUoArYCDgIQARYAtABgAEMAI1AXmAwQDY4CQAHIAQABCADQAHwATAAngBSAC-AGIAMwAhABHAClgIOAhABFgC0AGAAXmAAA.YAAAAAAAAAAA",
        "https://eus.rubiconproject.com/usync.html?p=19564_2&endpoint=us-east&gdpr=1&gdpr_consent=CO7Hn9TO7HoCpASABCENA6CsAP_AAG_AAAYgGxwIAAAgAKgAYABoAEgAOQAgACEAGgAOgAfABFgCYAJoATwApABbAC_AGEAYgAzAB4AD8AIAAQkAjgCPgFIAUoArYCDgIQARYAtABgAEMAI1AXmAwQDY4CQAHIAQABCADQAHwATAAngBSAC-AGIAMwAhABHAClgIOAhABFgC0AGAAXmAAA.YAAAAAAAAAAA",
        "https://ams.creativecdn.com/tags?type=iframe&id=pr_xhTnXtOx50jOnWfwIwkY_home&tc=1",
        "https://a3013110282.cdn.optimizely.com/client_storage/a3013110282.html",
        "https://www.medtargetsystem.com/beacon/portal/?_url=https%3A%2F%2Fwww.newyorker.com%2F&_sid=b57e32ba-6720-46cf-bffd-5b42c2148e87&_vid=e807871f-26bc-4ffa-aa70-ba200cb61578&_ak=119-536-9A036248&_flash=false&_th=undefined%7C1602587609%7Cundefined",
        "https://tr.snapchat.com/cm/i?pid=da17f2f6-35e0-46e3-b2ec-3f325753384d",
        "https://d1jow6p6g37b9u.cloudfront.net/1I5Z20ucHo6CF0SQCXRY0YdREn9ZDUmNBoSEBY6B6mRQAVqt1F6Z24KC9Via-FmTF2xS24i60IqM-2qiEnWZ13yC0EKWA3CtFGtS24u68UuJAX-MCWxS94ysCGOY7HtUG2pS9IesD3pQAGmXCGxS24i600qY7IyH11-0BUWtGGdVHo6cHo6B6mRQAVqt1F6Z20WE0XWVAH-20Xe324uB0GiZ7n-uFHSz2k-cHo5R10dT10JR0EJQohJg?TI=MQA3j5TxzwUMMYN#goog_1789187359",
        "https://rpt.cedexis.com/f1/_CgJqMRAUGHoiBQgBEL5YKNuj_bIPMJvWuvwFOJvWuvwFQNKgpsECSg8IAxA1GLFFIAAo74OAoARQAFoKCAAQABgAIAAoAGABahNidXR0b24xLmxoci5odi5wcm9kggEPCAMQNRixRSAAKO-DgKAEiAHZ7vOvApABAJgBAA/1/11326/42297/1,2/0/0/0/0",
        "https://www.google-analytics.com/collect?v=1&_v=j83&a=609127739&t=pageview&_s=1&dl=https%3A%2F%2Fwww.linkedin.com%2Ffeed%2F%3F&dp=flagship3_feed&ul=en-gb&de=UTF-8&dt=LinkedIn&sd=24-bit&sr=2048x1280&vp=2048x294&je=0&_u=QACAAAAB~&jid=&gjid=&cid=949688776.1596968678&tid=UA-62256447-1&_gid=1361093956.1603097042&cd24=https%3A%2F%2Fwww.linkedin.com%2Ffeed%2F%3F&cd25=1&z=1694576221",
        "https://sb.scorecardresearch.com/b2?c1=2&c2=6402952&c3=&c4=&c5=&c6=&c15=&ns__t=1603185424706&ns_c=UTF-8&c7=https%3A%2F%2Fwww.linkedin.com%2Ffeed%2F&c9=",
        "https://i2-iqihwplchtpqfeenjhkwgvkbykkzhp.init.cedexis-radar.net/i2/1/11326/j1/20/122/1603185435/0/0/providers.json?imagesok=1&n=1&p=1&r=1&s=1&t=1",
        "https://assets.bounceexchange.com/assets/bounce/local_storage_frame16.min.html#1990",
        "https://accounts.google.com/ServiceLogin?continue=https%3A%2F%2Fm.youtube.com%2Fsignin%3Faction_handle_signin%3Dtrue%26app%3Dm%26feature%3Dmobile_passive%26hl%3Den%26next%3Dhttps%253A%252F%252Fm.youtube.com%252Fsignin_passive%26noapp%3D1&hl=en&ltmpl=mobile&passive=true&service=youtube&uilel=3",
        "https://ufpcdn.com/script/identify.html?frmt=0",
        "https://onclickgenius.com/script/i.php?stamat=m%7C%2C%2Cg2M6difzoGU3BZ9GH0dEdHP3xP.898%2CdykBTumZoMUuis6WFoOaFf6t9vHFosfN7DuJtMd_tppveqW_5eryWFhAYefsCzuytdHUgsVgtua-Dd2Zlvz7xFNoqFQ4GO1IlUJgWUeMnD8bP-0kldfG_3EgoMzZTHBf5lZnRYGknMU0o4kUz3e1mnL1EAjWhwYoDUh8sVYUdDjXOM8CDvYClMawHTJgOMn1FxEHrVXDZ-NcBFwrCmh_fNzH-KsJlQ7qGOOngxhADE_nLocKIeA7qQM-O258RFMpZ4cQkyuxpKHnJeSkAjF2DAp0cy0Kg_vHJ5_2TULcBMp6cwZ4LHPj2aeinKF9ONgrhyey6LzaH7WspzvX50hScS4uwe6DYSr3qIWWpCsK6lV1MuekmgeLTxnJDbneT0FDyMRMB4yDOVUfO9xvdZ2ZWeaCVe1k1i0BjmoTYVS2sLXZughts8YOkbMxfn0xty1Z55yzSlwujOE--ii8kCkE-Q%2C%2C&sr=1",
        "https://app.appsflyer.com/id583009522?pid=adcash_int&c=AdCash_CPI_T2_iOS&af_cost_currency=USD&af_cost_model=CPI&af_cost_value=0.80&af_click_lookback=7d&clickid=16037127571484955541013251528138112&advertiser=133648&af_siteid=3303429",
        "https://onmarshtompor.com/fac.php",
        "https://rakamu.com/gtm.js?id=1605003&pb=d035d4b916be431f68eb0b429aa25fa81603720734&psp=WRWBmnaR9N5ufb-6HB2e7qPT6Bs8lvJ89nVlLsMKdbytPu70z8sQ3xRD88cxKwuXDFl1zW8YQspU6BgKVvFAfsUDTwP1IYaKD68NuDQzjEReaw1w5iEu5gr-QwmUwda_GNxm0adkpbKif11mhVk_Wk_C5bi0IlMlacFuEnuNpPhwPtWNhFt_-b6Zy0zTuToZC_zJRLqylAFRAg_2P4OSHdkp8wB7aqWQ-Vnmo4sWMdNnySbJCjzF7ZfQl4MhWNs6g7lWsmZPHhJy9vn10J6AdVKzyOZ_tlaJxmUrv-VAB6LQDwG3sTyZVO437kgsp9kFZmpZWmeRSkeGHKC61B5FjGq6dhCDNNMgjDkI8k7qCSlK9r9R4LEqGBYl3xNwbt6izIlw3G9ZXxTevIHeSe7yAlPdxAv52Qe67PJWtX3Q397en9mP_WtQMmAbxam0VMQdQFHFO85gFxXyyz5vs5heY5XqmW8qnqoBYmsa1ChoxxMfX9cihAQ44_GwM9DqFZYht-eZY4Tbdvc=&sp=2&nojs=0&ix=0&t=1&x=801&y=801&wcks=1&wgl=1&cnvs=1",
        "https://bongacams.com/track?c=373640&subid=2010260701b188bdcb8b1349a383f05e2f05&subid2=1605003",
        "https://bngpt.com/hit.php?c=373640&subid=2010260701b188bdcb8b1349a383f05e2f05&subid2=1605003",
        "https://user-shield.com/stream-secure-video-stream/?pid=adcash_int&c=224426820_23102790&af_siteid=3303429&af_click_lookback=7d&clickid=16037142711484955541100434613173325&advertiser=105233",
        "https://c.adsco.re/#0.7374381790311297",
        "https://www.bet365.com/favicon.ico",
        "https://caradstag.casa/cuid/",
        "https://monkposseacre.casa/iGYXvPEkSltqIsXKYIF/14919/?scontext_r=VLJ7xoeQEJMskmCu9NoqzF2yKbZIFVBr601NBbfVK3k&md=weiEmI6EDM1ADLiMnI6IyM3UDe4EjMiwiIiJiOiMzN1g3NzQjIsIiciojIoRHdwNnOv8yd3dnLn92bnxWZuM2btJCLigmI6IzN5IDLiwmI6ISZu1yZiJCLiQnI60iNwwiI6JiO4kzMzwiIrJiO0wiI1JiOiUjZ5YzY1MmM1QmMjZjIsIiZiojZhx2clxiIlJiOiEHailzNmRzdrZTay9me2JCLi0mI6EjNwMzNxYjN0cTNzQTf",
        "http://apostropheemailcompetence.com/njx43m3j?zvc=72&refer=https%3A%2F%2Foload.party%2Floadsource.php%3Fserver%3D12%26id%3D121561924%26token%3DWDNLeUZNbjBjVUU5QlM3SXNnR3NUaTFkSk9ZYmd0c0w5Nm5FUnNUNGQyNEE2TWlVV1BaNjFSODNtYzRTcnpXQ3d3MUF3bnJLbFpMbmJlWlRtcWw5ZWcxeHRQWmo4RXh1MTVuRWVTcE0venVZakRvVi9ZMVNuTXZIVm9xNkpUb2lXRWRsYjY5VU1na2JMSGJmaW5Sa3ppWFFCa1F3T3N2Rk1IR3VQUlpzODk5UmxkbHJzUHlSZFJQMWNpYkJxZmVn&kw=%5B%22watching%22%5D&key=fcadcc451dab8bff46b41e2b67adc80c&scrWidth=375&scrHeight=812&tz=1&ship=&pst=&v=20.8.v.1&res=7.229&dev=r&adb=n",
        "https://fgfgnbmeieorr910.com/gtm.js?id=1587358&pb=f14d8eb8972ab59bee14da9e15970a211603724254&psp=c0enK22uCCmLANsJI5C5h_Abx7yodpBMiNXehHA5fPHeUae0J_18hSPX7WZmSHJmMzPyVZ0OxPKUAK2zl34FAERUK05QFT98QUSoNeH0b8kx9q9YalPOc1vR3w8gVyyOdJEx6gjrT5lluJbyN4X4seIWLoDjBZklasn4_LgeglQGQ27qSbCpsfKXouEdQdAA8RKMUMrwkvR1RccQTBs0H63gkSzV-kNB044LHvjjcesn_SICCpHLam_6NfRyOdXSLdfaUlWuMUADfuCjoqzAFRL-3l6U1e9vmNqCx2yrr4fGGL-ZhM03IysKU7brUcz9gB4w7pG0c2DUxY3IdVH51wNVE2-NN6pa8eHN1ZLK04ezaYiaRmSi5cRvjy__l3xiwyIR6TXN4rZfUmBt-U4yEB8fJEVOJo3HG9YV8CtDhQ4NaPw2vr7ctgp8Efq-_c19JJa-t74nefoNPTdV5AEubvWJAhokpJJyBj4s0-MUL4yZsVdmbKYqzP9RyhI1xWw_HMc4T9eAMEZdL5jJOMx4ZIrqX4XHaf8X5wCID1SlmwyRLWDe8OyoZkv3EIfDr9N89T3TwnqOpCsqYGks6-xS9okrlcE=&sp=2&nojs=0&ix=0&t=1&x=801&y=801&wcks=0&wgl=1&cnvs=1",
        "https://www.dexpredict.com/jump/next.php?r=2692607",
        "https://hornsgrid.com/ng7y2swh3?key=17d7f7655624c90e52f1293128c0fd22&psid=MP1P3_1093",
        "https://zap.buzz/pA0BjA7",
        "https://xml.zeusadx.com/redirect?feed=249568&auth=UbRt0Q&pubid=105595",
        "https://xml.adxnexus.com/redirect?feed=249569&auth=JoKr8C&pubid=102594",
        "https://xml.revrtb.net/redirect?feed=249573&auth=fLiSI9&pubid=102592",
        "https://xml.acertb.com/redirect?feed=249566&auth=WBe8j6&pubid=112746",
        "https://xml.popmonetizer.net/redirect?feed=249572&auth=oZ6Qhn&pubid=102593",
        "https://tiodmw.com/dsp/cu/clc?aid=4230258513742548404&t=1603717176&s=426015&sid=818",
        "https://ratappe.com/dsp/cu/clc?aid=10021440260153756788&t=1603717176&s=426015&sid=713",
        "https://t.riverhit.com/1/?spot_id=5706",
        "https://ahojer.com/fp.html?rid=4230258513742548404_2&sd=aHR0cHM6Ly90aW9kbXcuY29t&ru=aHR0cHM6Ly90LnJpdmVyaGl0LmNvbS8xLz9zcG90X2lkPTU3MDY=",
        "https://impactserving.com/link.engine?z=16121&guid=fe89a1e1-ef4a-4953-b915-7e5e3ea14d77",
        "https://f853150605ccb.com/go.xml",
        "https://acdn.adnxs.com/dmp/async_usersync.html",
        "https://buy.tinypass.com/checkout/offer/show?displayMode=inline&containerSelector=.login-box&templateId=OTU6M3FSD4MZ&templateVariantId=OTVN7R7RXGJUZ&offerId=OF5GTA24P5VH&formNameByTermId=%7B%7D&showCloseButton=false&experienceId=EX8P88MXOZPZ&widget=offer&iframeId=offer-0-tay0l&url=https%3A%2F%2Fwww.thelocal.de%2F20210406%2Fcould-a-bridge-lockdown-be-the-answer-to-germanys-spiralling-covid-cases%2F&parentDualScreenLeft=0&parentDualScreenTop=1120&parentWidth=1391&parentHeight=952&parentOuterHeight=0&gaClientId=1513133894.1617707433&aid=lGr3ciYmC7&pianoIdUrl=https%3A%2F%2Fid.tinypass.com%2Fid%2F&userProvider=piano_id&userToken=&customCookies=%7B%7D&hasLoginRequiredCallback=true&width=350&_qh=63f5169ba6",
        "https://gslbeacon.lijit.com/beacon?viewId=a_423415_eb9ea5f998ca4f1c922106abdb91aca3&rand=8596&informer=13194752&type=fpads&loc=https%3A%2F%2Fwww.thelocal.de%2F20210406%2Fcould-a-bridge-lockdown-be-the-answer-to-germanys-spiralling-covid-cases%2F&v=1.2",
        "https://api-esp.piano.io/publisher/bekose/162?wv=97&v=vd.1.62.6-454b540",
        "https://z.moatads.com/hd09824092/iframe.html#header=1",
        "https://www.facebook.com/v2.2/plugins/login_button.php?app_id=274266067164&button_type=continue_with&channel=https%3A%2F%2Fstaticxx.facebook.com%2Fx%2Fconnect%2Fxd_arbiter%2F%3Fversion%3D46%23cb%3Df128a66805b8d8a%26domain%3Dwww.pinterest.com%26origin%3Dhttps%253A%252F%252Fwww.pinterest.com%252Ff3e4c8a1fc181f%26relation%3Dparent.parent&container_width=268&layout=rounded&locale=en_GB&login_text=&scope=public_profile%2Cemail%2Cuser_likes%2Cuser_birthday%2Cuser_friends&sdk=joey&size=large&use_continue_as=true&width=268px",
        "https://www.redditmedia.com/gtm/jail?id=GTM-5XVNS82",
        "https://www.reddit.com/account/sso/one_tap/?experiment_d2x_2020ify_buttons=enabled&experiment_d2x_sso_login_link=enabled&d2x_google_onetap=onetap",
        "https://trendads.reactivebetting.com/sportwetten-de/?autoFill=true&sport=Football&matchCount=6&template=MatchBanner&size=300x250&adServerClickPrefix=https://track.adform.net/C/?bn=46264906;crtbwp=0.033233-cJcCUlF0X_HZrEeplYLuvw6_sZOb84a20;crtbdata=IMiTb-5dnjlzY9nwYqMmy3EjLc9RcWyas_9QU25NttVvouDsKOoBdcQZ4-CVf_Ta3vVXFYhyQ44Stt9Z5MN5Eqh2bk0vkbv8aKoc5c5rxTERnXjN2KRhr3SKDJJD2ewhZMYQ-2p3MhzIcGI9OVDg6bHrJtCjkh2RGVUJHyO-GnHyx94rACH3Ix7FHltRd8MR_5NszeE6BeS-9qkOgYDXR6oJq50NeVtaVYonnC5U-joQE3czMahyhK5nVgPMPdUUM76iREhjt-2auzmQWr98GazrWX5tnEIROlOOucqlDIyhuoPDmTJxreSEpmlthTfx_h7aDuTW3OCozOwgPm3njelYia4DfFfRSf4KuTbQp-_2WDq8dWY2060tFO7JKHuxSsdEZnksRsmGZNbn-MxEwxHDrGSiS9VpHhyooSkN56ChItMEbScWxcjeZ3lYBTFzewS-muCIq988PsgcOvmMFmlOBJ9sAv0-vnCyOQ9wPPyYB3FjHJe0Cz4zp1iVmyCrybTzf1jlMj0DhlL8WRe0pmeZ2m9iTzf1Vq8sZOKwXhXmJY83OeN9iyADwLu-QcAGn7hLRNoRfgF8wyUHCxHJu5-4S0TaEX4B2W3-0bSYVUefuEtE2hF-AUQ-SfpZhDUKNAK3t8TwYVt8slQ2KA_3LsN4iOtIBxgX0;adfibeg=0;cdata=KWLHl36L32xlLF9lAlRJmjlLigPwNVY9awF2S0tc_VzV_ytThLqJ9K_4-eiGwxt1v4SWAEqCeluQzzB43T24cqwaFF5VbmZtKd_h3HRzrfpk9JUJFwE_MQ2;;CREFURL=https%3a%2f%2fbigseventravel.com%2fberlin-weather%2f;C=1;cpdir=",
        "https://edigitalsurvey.com/l.php?id=INS-vt29-666188954&v=7291&x=1792&y=1120&d=24&c=null&ck=1&p=%2Fworklife%2Farticle%2F20210604-why-presenteeism-always-wins-out-over-productivity&ref=https%3A%2F%2Fwww.bbc.com%2Fnews%2Fworld-europe-17842338&fu=https%3A%2F%2Fwww.bbc.com%2Fworklife%2Farticle%2F20210604-why-presenteeism-always-wins-out-over-productivity&xdm=edr&xdm_o=https%3A%2F%2Fwww.bbc.com&xdm_c=edr0",
        "https://cdn.concert.io/lib/adblock/verge.html",
        "https://phonograph2.voxmedia.com/third.html",
        "https://cdn-gl.imrworldwide.com/novms/html/ls.html",
        "https://usersync.getpublica.com/usersync?gpdr=1&consent=CPHrrS0PHrrS0AcABBENBeCsAP_AAAAAAChQH6Nf_X__b3_j-_59__t0eY1f9_7_v-0zjhfdt-8N2f_X_L8X_2M7vF36pq4KuR4Eu3LBIQdlHOHcTUmw6okVrTPsbk2Mr7NKJ7PEmnMbe2dYGH9_n93T-ZKY7__v___7__-_____7_f__-__3_v59V--wAAAAAAAAAAAAAIAAAHAAAAkEAYgACgAcAB4AFwAPgAtAB8AEYAJIAYgA_gCRAFcAM0AbQA4gByADnAHUAP8AgYBBwCRAE_AKGAYQA6oCHwEegJCASsAm0BYQC6AF1ALtAXkAxABiwDIQGRgMoAaEA0YBpQDUwG0ANuAboA4IJBXAAQAAuACgAKgAZAA4AB4AEAAIgAYAAygBoAGoAPIAhgCIAEwAJ8AVQBWACwAFwAN4AcwA9ACEAENAIgAiQBHQCWAJcATQApQBbgDDAGQAMuAagBqgDZAHeAPYAfEA-wD9AIBARcBGACNAEcAJSAUEApYBTwCrgFzAL8AYoA1gBtADcAG8APQAfIBDYCHQEXgJEATEAmUBNgCdgFDgKRAU0AsUBaAC2AFyALvAXmAwIBgwDCQGGgMPAZEAyQBk4DLgGcgM-AaQA06BrAGshgCgACwALgBGACSAFUAMQAbwBpADVAHEAS0A6gCQgFDgLEAX0AxYBkYDQgG6BoEoAVgAuACGAGQAMsAagA2QB2AD8AIAAQUAjABSwCngFXgLQAtIBrADeAHVAPkAhsBDoCKgEXgJEATYAnYBSIC5AGBAMJAYeAxgBk4DOQGeAM-EAFAAFgAXABqAEYAJIAVQAxABvAFcANUAcQBIgCWgG4AN4AkIBQ4DFgGhAN0EQHwArABcAEMAMgAZYA1ABsgDsAH4AQAAjABSwCngFXANYAdUA-QCGwEOgIvASIAmwBOwCkQFyAMCAYSAw8Bk4DOQGfCoDoAFAAhgBMAC4AI4AZYA1AB2AD8AIwARwApYBV4C0ALSAbwBIICYgE2AKbAWwAuQBeYDAgGHgMiAZyAzwBnwDchQA8AMQA1QBtADiAHIAPAAgoBLQDqgI9AWIAvoBmgDQgGvDIDQAFAAhgBMAC4AI4AZYA1AB2QD7APwAjABHAClgFXAK2AbwBMQCbAFogLYAXmAwIBh4DIgGcgM8AZ8MAHgA1ADEANUAbQA4gByADwAJaAWIA6oCPQEnALEAXkA0IcBbAAEAAiABwAHgAXAA-AC0AHIAPwAggBGAC6AGQANAAfwBIgCdAFmAMsAZoA0gBqgDaAHEAOQAc4A6gB2ADuAIAAQMAgsBBwEIAIiASIAloBNoCfAJ-AUsAqABbQC9QGAAYEAwgBmQDWAGvAN4AccA6QB1QDyAHyAQhAh8CIAEegJCgSsBK4CYgEygJtAUKApABSYCmAFTAKqAVsArkBXYCygFpALUAXFAugC6gF7AL6AYEAxABiwDIQGUAMvAaFA0UDRgGlANNAamA14BtADbAG3DoMwAC4AKAAqABkADgAIAARAAugBgAGUANAA1AB4AD6AIYAiABMACfAFUAVgAsABcAC-AGIAMwAbwA5gB6AEIAIaARABEgCOgEsATAAmgBRgClAFiALeAYQBhgDIAGUANEAagA2QBvgDvAHtAPsA_QB_wEWARgAjkBKQEqAKCAU8Aq4BYoC0ALSAXMAuoBeQC_AGKANoAbiA6YDqAHoAQ2Ah0BEQCKgEXgJBASIAlQBNgCdgFDgKaAVYAsUBaEC2ALZAXAAuQBdoC7wF5gMGAYSAw0Bh4DEgGMAMeAZIAycBlQDLAGXAM5AZ8A0SBpAGkgNLAacA1gBsZABgAAgAH4AQQA0AB_AEiALcAZYA1QBtADiAHIAOcAdgA8ACCgE-AKWAWIAwABhADMgG8AOqAdsBD4CPQEhAJOASuAmIBNoChQFIAKTAVsAugBeQC9gF9AMCAZoA0IBooDSgGpgNsAbcQgeAALAAoABkAEQALgAYgBDACYAFUALgAXwAxABmADeAHoARwAsQBhADKAGoAN8Ad8A-wD8AH-ARgAjgBKQCggFDAKeAVeAtAC0gFzAL8AYoA2gB1AD0AJBASIAlQBNgCmgFigLRgWwBbQC4AFyALtAYeAxIBkQDJwGcgM8AZ8A0QBpIDSwHAEgEYAAgAHAAXABCADkAMgAbwBIgC5AF8AMsAagA2gB3AEAAISAS0AnwBUADXgG8AOqAfYBKwCbQFJgLKAWkAvYBfQDEQGLANCAaUA3IlA6AAQAAsACgAGQAOAAigBgAGIAPAAiABMACqAFwAL4AYgAzABtAEIAIaARABEgCOAFGAKUAW4AwgBlADVAGyAO8AfgBGACOAFPAKvAWgBaQC6gGKANwAdQA-QCHQEVAIvASIAmwBYoC2AF2gLzAYeAyIBk4DLAGcgM8AZ8A0gBrADgCgEQAAQAFwAPgAhABaADkAH4ARgArABkADaAG8AOQAjgBIgCdAFyAMsAagA1wBtADiAHOAOoAdwA8ACAAEHAISARUAkQBLQCbQE-AT8ApYBYgC6gGAAMIAYoA14BvADqgHbAPIAfIA_4CPQExAJlATaApABTACpgFdgLQAXQAvIBfQDAgGLANCAaIA0oBpsDUgNTAa8A4IpBJAAXABQAFQAMgAcABAACKAGAAZQA0ADUAHkAQwBEACYAE8AKQAVQAsABcAC-AGIAMwAcwBCACGgEQARIAowBSgCxAFuAMIAZQA0QBqgDZAHfAPsA_QCLAEYAI4ASkAoIBQwCrgFbALmAXkA2gBuAD0AIdAReAkQBNgCdgFDgK2AWKAtgBcAC5AF2gLzAYaAw8BjADIgGSAMnAZcAzkBngDPoGkAaTA1gDWQGxgAA.f_gAAAAAAAAA&us_privacy=",
        "https://imprammp.taboola.com/st?cipid=7991117&ttype=0&cirid=18792F804964310431492380876&cicmp=1337627&cijs=1&dast=V73pACFgMx4ZFo0aUEZgQx4ZFo0aUEZgUAAAAGBugHGzHcLScz4mC0nI02i8FoshiMNrvNYjIcLiFhFovFaDJbDadgsIXP6e5uAwaaTofPda_X_X530dFl9nscZrvI5ZcDAAAAwAMAUUs0xI5vQ3sEAAAAgATPyLUCRUDFv4XABQAAAAAGAIFYuAYAFIeBuCxnp90fAAADASAAAAMKIQArlLwiAAAAACMAAAAAJAACiYUlAA53iyYAAAF6AIsVUCcAAAAHdTJP2yz_____MQB5700yABRpGzcGPQAPPgAPQgAAABdDnTKYF0G0cmVEBahFjAAAAAB8OofUjyZ1QmVR9f___28FcAUAEKAHsFjhlnVzUswaBgAAADC2QA-L32922DV-t8v-_________83-zwDQhKQAANKCqJib1XhGrhXWfgEBANjeDQDgTQAu5gDsAAAAAO7-____8wAAAFj2KNleq_HsUdb7DLbwOd3d9Zuw5WS02i2Hs81utByOJqvBcH8CMRrgBA2Hg8VusNgtFsPJYjIaLAcLFIjBBCdkONpMVqPdajdZDiej0Wwz2SBFq1az0WYwXM0ms91uNRwMl6MRUrRmMZtMFrPRcrcZLCejwXAyHOJB1bl0Pq_OxwabzBWr3Vy2m0s2o1UCAAAAAAAAAFjClHkTAAAAgNMgZrPJbrfixps9E8RarZY1AAAAALdu5AA!&excid=22&tst=1&docw=0&cs=false",
        "https://www-nunesmagician-com.cdn.ampproject.org/v/s/www.nunesmagician.com/platform/amp/2021/6/2/22450031/womens-sports-are-growing-and-no-glass-ceiling-can-stop-them-syracuse-orange-basketball-lacrosse?amp_js_v=0.1&usqp=mq331AQHKAFQArABIA%3D%3D#origin=https%3A%2F%2Fwww.google.com&prerenderSize=1&visibilityState=prerender&paddingTop=32&p2r=0&csi=1&aoh=16238409249772&viewerUrl=https%3A%2F%2Fwww.google.com%2Famp%2Fs%2Fwww.nunesmagician.com%2Fplatform%2Famp%2F2021%2F6%2F2%2F22450031%2Fwomens-sports-are-growing-and-no-glass-ceiling-can-stop-them-syracuse-orange-basketball-lacrosse&history=1&storage=1&cid=1&cap=navigateTo%2Ccid%2CfullReplaceHistory%2Cfragment%2CreplaceUrl%2CiframeScroll",
        "https://stags.bluekai.com/site/50134?ret=html&phint=regid%3D&phint=usertype%3Danon&phint=userloggedin%3Dfalse&phint=coresubtenure%3D&phint=corestop%3D&phint=corepromo%3Dfalse&phint=ingrace%3Dfalse&phint=giftrecipient%3Dfalse&phint=childsubrecipient%3Dfalse&phint=bundlecoredigi%3D&phint=bundlecorehd%3D&phint=bundlexword%3D&phint=bundlecooking%3D&phint=bundleother%3D&phint=b2bentitle%3Dfalse&phint=marketingoptin%3Dfalse&phint=formercoresub%3Dfalse&phint=formeredusub%3Dfalse&phint=formerhdsub%3Dfalse&phint=retentionscore%3D&phint=topwatseg%3D&phint=sassegment%3D&phint=hdstopreasoncode%3D&phint=regitenure%3D&phint=cookinggrace%3Dfalse&phint=crosswordsgrace%3Dfalse&phint=gatewayhitlm%3Dfalse&phint=coregracelevel%3Dfalse&phint=activedaysengagement%3D&phint=authors%3D&phint=newsletter%3D&phint=businessname%3D&phint=corpadblock%3Dfalse&phint=isedu%3D&phint=propensityedu%3D&phint=propensityscore&phint=activedays%3D1&phint=metercount%3D&phint=propensitysection&phint=propensitytype&phint=propensitysite&phint=url%3Dhttps%3A%2F%2Fwww.nytimes.com%2F&phint=referrer%3Dhttps%3A%2F%2Fwww.google.com&phint=section%3DHomepage&phint=subsection%3D&phint=pagetype%3DHomepage&phint=keywords%3D&phint=sourceapp%3Dnyt-vi&phint=browsername%3DSafari&phint=funnelpropensity%3D0&phint=column%3D&phint=collectionname%3D&phint=contenttype%3Dsectionfront&phint=emotions%3D&phint=xwordstenure%3D&phint=cookingtenure%3D&phint=xwordsstop%3D&phint=cookingstop%3D&phint=productswitch%3D&phint=giftsubgiver%3Dfalse&phint=formerxwordsub%3Dfalse&phint=formercookingsub%3Dfalse&phint=watsegs%3D&phint=edusub%3D&phint=aiqaudience%3D&limit=4&r=32254731",
        "https://static01.nyt.com/ads/tpc-check.html",
        "https://httpbin.org/base64/PHNjcmlwdD5vbm1lc3NhZ2UgPSBlID0+IGUuZGF0YS5wb3N0TWVzc2FnZShuYXZpZ2F0b3IuY29va2llRW5hYmxlZCk8L3NjcmlwdD4=",
        "https://app.visitor-analytics.io/empty_widget.html?lang=en&dateNumberFormat=en-ie&isPrimaryLanguage=true&pageId=masterPage&compId=comp-klgb4w2f&viewerCompId=comp-klgb4w2f&siteRevision=468&viewMode=site&deviceType=desktop&locale=en&tz=Europe%2FBerlin&regionalLanguage=en&width=5&height=5&instance=tf3bID0_vc7JWUeJwGFBoYsrfQxSxMfKd0UZR4hj250.eyJpbnN0YW5jZUlkIjoiZGI4MGIxYjMtNTI5Ny00Mjc4LWFkOTktYTdhMTIzZDljYThjIiwiYXBwRGVmSWQiOiIxM2VlNTNiNC0yMzQzLWI2NDEtYzg0ZC0wNTZkMmU2ZWQyZTYiLCJzaWduRGF0ZSI6IjIwMjEtMDYtMThUMDk6NTM6MjAuODY5WiIsImRlbW9Nb2RlIjpmYWxzZSwiYWlkIjoiOGUzYmJiMWMtMGZlOS00YjYxLThjYTQtNmFiM2JkNzU4Y2MyIiwic2l0ZU93bmVySWQiOiI2YzUzZDU3ZC04ZjU1LTQ2N2UtYmI3NC1iNWRiZWE2MjljMGUifQ&currency=EUR&currentCurrency=EUR&commonConfig=%7B%22brand%22%3A%22wix%22%2C%22bsi%22%3Anull%2C%22BSI%22%3Anull%7D&consent-policy=%7B%22func%22%3A0%2C%22anl%22%3A0%2C%22adv%22%3A0%2C%22dt3%22%3A1%2C%22ess%22%3A1%7D&vsi=f4c23d22-f83c-46b4-8ec5-eddf106a2a59",
        "https://ecom.wix.com/storefront/cartwidgetPopup?lang=en&dateNumberFormat=en-ie&isPrimaryLanguage=true&pageId=masterPage&compId=tpapopup-1624010002060_rtby_i43uht4e&viewerCompId=tpapopup-1624010002060_rtby_i43uht4e&siteRevision=468&viewMode=site&deviceType=desktop&locale=en&tz=Europe%2FBerlin&regionalLanguage=en&width=27&height=32&origCompId=i43uht4e&instance=h3dwKYZLKyUDxDHEXnKfHSa8tvhKCToHzh3qzdE-kNw.eyJpbnN0YW5jZUlkIjoiYTZlZTMyMTktNTAzMS00YTFiLThkY2YtZjcwMDc2ZTQwYTNhIiwiYXBwRGVmSWQiOiIxMzgwYjcwMy1jZTgxLWZmMDUtZjExNS0zOTU3MWQ5NGRmY2QiLCJtZXRhU2l0ZUlkIjoiNzZiMzJmMjktMGM5OS00YzQzLWI4MDgtMDY2NzI0MGZlZWIxIiwic2lnbkRhdGUiOiIyMDIxLTA2LTE4VDA5OjUzOjIwLjg2OVoiLCJ2ZW5kb3JQcm9kdWN0SWQiOiJzdG9yZXNfZ29sZCIsImRlbW9Nb2RlIjpmYWxzZSwib3JpZ2luSW5zdGFuY2VJZCI6Ijk1OTExZGU1LTJkOGMtNDdhNC1hNjVlLTBkNzI3Yjk0ZDk1NiIsImFpZCI6IjhlM2JiYjFjLTBmZTktNGI2MS04Y2E0LTZhYjNiZDc1OGNjMiIsImJpVG9rZW4iOiJkMDVkMWQzMC01Y2E4LTA2NTgtMzVjNy1mMTY3NTJlYmU0OGIiLCJzaXRlT3duZXJJZCI6IjZjNTNkNTdkLThmNTUtNDY3ZS1iYjc0LWI1ZGJlYTYyOWMwZSJ9&currency=EUR&currentCurrency=EUR&commonConfig=%7B%22brand%22%3A%22wix%22%2C%22bsi%22%3Anull%2C%22BSI%22%3Anull%7D&consent-policy=%7B%22func%22%3A0%2C%22anl%22%3A0%2C%22adv%22%3A0%2C%22dt3%22%3A1%2C%22ess%22%3A1%7D&vsi=f4c23d22-f83c-46b4-8ec5-eddf106a2a59",
        "https://pixel.mathtag.com/sync/iframe?mt_uuid=dfe360db-1b98-4c00-8386-6a9f50ee6361&no_iframe=1&mt_adid=184981&mt_lim=20&source=mathtag",
        "https://www.facebook.com/tr/",
        "https://d.adup-tech.com/iframe?p=481057718b40bd81664172de03402f8a&r=0&s=0&a=0&f=01&id=6ynr285n&gdpr=1&gdpr_consent=CPHEY9fPHEY9fAGABCDEBcCgAP_AAAAAAAYgGnAZ5CpUTWFAUXJ8QtsAGYQUUEQEAWACAACAAiABAAEAMKQAgUAAoASAAAACAAIAIAIBAAAACAAEAUAAQAAEAAEAAAAAgAAIIABEAAAAAAAAAAoAAAAAAAAIAAABAAAAkAAAAmIEAGAIkAAQAAAHjIAoATAAuAEcAXmAz4RAGAC4AIYBDYCLwEiAM-CQIwAFgAVAAyABwADwAIAAZAA0AB5AEQARQAmABPAC4AG8AOYAhABDAClAGGANUAfoBAwCNAEcAMUAbgA4gB6AENgIvASIAocBeYDPgGnBoBAAXABDAEFALSAhsBF4CRAGfBgAIB1BUAYAJgAXACOAFpAXmAz4UABAIKOgUAALAAqABkADgAIAAZAA0AB4AD6AIgAigBMACeAFwAMQAbwA5gCEAEMAJgAUoAsQBhgDRAH6AQMAjgBaQDFAG4AOIAdQA9ACGwEXgJEAUOAvMBlgDPgGnDgBIAFwAvgEFAIQARYAuoBgQDXgIgIQDwAFgAZACYAFwAMQAbwBYgEcALSAYoA6gB6AEiALaAZ8QABABfAIKSgLAALAAyABwAHgARAAmABcADEAIQAQwApQBqgEcALSAYoA3AB1AEXgJEAXmAywBnxIAIABcAL4BdQDXlIDoACwAKgAZAA4ACAAGQANAAeQBEAEUAJgATwAuABiADmAIQAQwApQBYgDRAGqAP0AjgBuAD0AIvASIAocBeYDPigAcAC4AXwCLAE7ALqAYoA14AAA.YAAAAAAAAAAA&uid=1xwiTZbBL7BSlg3ZVOdX&surl=www.spiegel.de%2F&sref=www.spiegel.de%2Fconsent-a-%3FtargetUrl%3Dhttps%253A%252F%252Fwww.spiegel.de%252F",
        "https://tarifvergleich.spiegel.de/multiwidget1?vxcp_productType=mobile",
        "https://widgets.outbrain.com/nanoWidget/externals/cookie/put.html",
        "https://cdn.conative.de/libs/uu-track/uu.html",
        "https://mobileads.google.com/appEvent?name=sitedefault&info=true&google.afma.Notify_dt=1625136586354",
        "gmsg://mobileads.google.com/appEvent?name=sitedefault&info=true&google.afma.Notify_dt=1625136586354",
        "https://insight.adsrvr.org/track/up?adv=vygbing&ref=https%3A%2F%2Fwww.meetup.com%2F%3F_xtd%3DgatlbWFpbF9jbGlja9oAJDQ4MGZmOTU2LTQxZDItNGE3NS05NmQ4LTU5YjBiZTlhM2Q5NA%26utm_campaign%3Devent-announce%26utm_medium%3Demail%26utm_source%3Dpromo%2F&upid=u4wwibb&upv=1.1.0",
        "https://api.bam-x.com/api/v0/session.html",
        "https://sync.teads.tv/iframe?pid=144161&gdprIab=%7B%22reason%22:240,%22status%22:24,%22consent%22:%22%22,%22apiVersion%22:null,%22cmpId%22:null%7D&fromFormat=true&env=js-web&hb_provider=prebid&auctid=55745f18-6bd9-4498-b9fb-6ccf9ea10aba_843008a2-5269-49c7-af97-0bddb2e0cce9&vid=254bd22eb05c23ee9f6d36b0ccb9023b2553f0bd&1625830986258",
        "https://gdpr-consent-tool.privacymanager.io/1/index.html#/notice?theme=blueLagoon&useSystemFonts=false",
        "https://s0.2mdn.net/ads/richmedia/studio/pv2/61692991/20210611014527589/300x250.html?e=69&leftOffset=0&topOffset=0&c=gzv2mTFCSu&t=1&renderingType=2",
        "https://sourcepointcmp.bloomberg.com/index.html?message_id=484987&consentUUID=7a978bad-c3e3-4ef1-84e0-5c3d6fc3d870&requestUUID=2b8b2e96-9038-439c-95dd-a404ce50beaf&preload_message=true",
        "https://www.bloomberg.com/subscription-offer?ledeText=&curationPage=&digitalRatePlanId1=2c92a0086614a669016615eb9d965f86&digitalRatePlanId2=2c92a0ff682d0657016833ee12df011d&allAccessRatePlanId1=&allAccessRatePlanId2=&inSource=article-wall",
        "https://trustarc.mgr.consensu.org/asset/cmpcookie.v2.html",
        "https://synchroscript.deliveryengine.adswizz.com/www/delivery/afr.php?zoneid=9&aw_0_req.gdpr=false",
        "https://tracking.immobilienscout24.de/consent.html"
    ]
    
    override func setUp() {
        router = .secure
    }
    
    func test() {
        list
            .map {
                ($0, router(URL(string: $0)!))
            }
            .forEach {
                if case .block = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
