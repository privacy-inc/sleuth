import XCTest
import Sleuth

final class PerformanceTests: XCTestCase {
    func testProtection() {
        let protection = Antitracker()
        var list = [String]()
        list += [
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
            "https://imagesrv.adition.com/banners/268/00/b3/65/06/index.html?clicktag=https%3A%2F%2Fde7.splicky.com%2Fclk%3Fmid%3D8805366030483347127%26aid%3D406208%26url%3Dhttps%3A%2F%2Fad4.adfarm1.adition.com%2Fredi%3Flid%3D6882352274847564137%26gdpr%3D0%26gdpr%5Fconsent%3D%26gdpr%5Fpd%3D0%26userid%3D6882352274847433065%26sid%3D4573083%26kid%3D3887752%26bid%3D11773239%26c%3D23805%26keyword%3D%255Bu%255Dtheguardian.com%255BIDFA%255D%255BAAID%255D%26sr%3D0%26clickurl%3Dhttps%3A%2F%2Fad2.adfarm1.adition.com%2Fredi%3Flid%3D6882352274857395416%26gdpr%3D0%26gdpr%5Fconsent%3D%26gdpr%5Fpd%3D0%26userid%3D6882352274857264344%26sid%3D4534627%26kid%3D3865979%26bid%3D11756806%26c%3D13762%26keyword%3DPACS%255F4573083%255F11773239%26sr%3D0%26clickurl%3D&gdpr=0&gdpr_consent=&h5Params=%7B%7D",
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
            "https://consent.google.com/?hl=en&origin=https://www.google.com&continue=https://www.google.com/search?q%3Dweather%2Bberlin&if=1&m=0&pc=s&wp=-1&gl=GR",
            "https://acdn.adnxs.com/dmp/async_usersync.html",
            "https://buy.tinypass.com/checkout/offer/show?displayMode=inline&containerSelector=.login-box&templateId=OTU6M3FSD4MZ&templateVariantId=OTVN7R7RXGJUZ&offerId=OF5GTA24P5VH&formNameByTermId=%7B%7D&showCloseButton=false&experienceId=EX8P88MXOZPZ&widget=offer&iframeId=offer-0-tay0l&url=https%3A%2F%2Fwww.thelocal.de%2F20210406%2Fcould-a-bridge-lockdown-be-the-answer-to-germanys-spiralling-covid-cases%2F&parentDualScreenLeft=0&parentDualScreenTop=1120&parentWidth=1391&parentHeight=952&parentOuterHeight=0&gaClientId=1513133894.1617707433&aid=lGr3ciYmC7&pianoIdUrl=https%3A%2F%2Fid.tinypass.com%2Fid%2F&userProvider=piano_id&userToken=&customCookies=%7B%7D&hasLoginRequiredCallback=true&width=350&_qh=63f5169ba6",
            "https://gslbeacon.lijit.com/beacon?viewId=a_423415_eb9ea5f998ca4f1c922106abdb91aca3&rand=8596&informer=13194752&type=fpads&loc=https%3A%2F%2Fwww.thelocal.de%2F20210406%2Fcould-a-bridge-lockdown-be-the-answer-to-germanys-spiralling-covid-cases%2F&v=1.2",
            "https://api-esp.piano.io/publisher/bekose/162?wv=97&v=vd.1.62.6-454b540",
            "https://z.moatads.com/hd09824092/iframe.html#header=1",
            "https://www.facebook.com/v2.2/plugins/login_button.php?app_id=274266067164&button_type=continue_with&channel=https%3A%2F%2Fstaticxx.facebook.com%2Fx%2Fconnect%2Fxd_arbiter%2F%3Fversion%3D46%23cb%3Df128a66805b8d8a%26domain%3Dwww.pinterest.com%26origin%3Dhttps%253A%252F%252Fwww.pinterest.com%252Ff3e4c8a1fc181f%26relation%3Dparent.parent&container_width=268&layout=rounded&locale=en_GB&login_text=&scope=public_profile%2Cemail%2Cuser_likes%2Cuser_birthday%2Cuser_friends&sdk=joey&size=large&use_continue_as=true&width=268px",
            "https://www.redditmedia.com/gtm/jail?id=GTM-5XVNS82",
            "https://www.reddit.com/account/sso/one_tap/?experiment_d2x_2020ify_buttons=enabled&experiment_d2x_sso_login_link=enabled&d2x_google_onetap=onetap"
        ]
        
        list += ["data:text/html;charset=utf-8;base64,PGltZyBzcmM9Imh0dHBzOi8vd3d3LmJldDM2NS5jb20vZmF2aWNvbi5pY28iPg==",
                 "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMSEhUTEhMWFhUXGRoXGBgYGRgaGRcaGRoYFxoYHxcYHSggGB0lHRsaITEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OGhAQGi0lHyUtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAPsAyQMBIgACEQEDEQH/xAAcAAACAgMBAQAAAAAAAAAAAAAFBgAEAgMHAQj/xAA8EAACAQMDAgQEBAUDAwQDAAABAhEAAyEEEjEFQQYiUWETcYGRMqGx8AcUQsHRI1LxFWLhM3KCoiRTkv/EABoBAAMBAQEBAAAAAAAAAAAAAAECAwAEBQb/xAAjEQADAQADAAICAgMAAAAAAAAAAQIRAyExEkEEURNhFCIy/9oADAMBAAIRAxEAPwDBtQTaGx1CgD+nynuJKgAYiFgTAqvpLDF2ZXIKEM7MQqhomCwMnkeXnFCrN8uFVnIWRIB/BK7jngQCeOOTFMSbIt27dofy6ljkNudtxAyckTBJPdqidW6D9T017wLMxVAdxZyR8QfKDtHMDn5kmFbqqhBuUiGB2wCMHB/EAT6zxn3px6tvuKwVSWMOzM2EwFRADyVQGSO5buMpvWtMYFwQAwhR3gAAk9ucD2X2p0yNIEaOw124FAkkxXYPDXRkspJ/F+npSl4T0duypYxvPf0Hb696abfVVnn7VO61lYnENehuKfT7VcUjNKNjqgLYxj5Vd03UiR9eamNgyI4FatXpLd0QwkUObUQCZ9THyzVddcZwcD1P79a2g+Iv+IvB6dv/AIniD7Ht8jigfhuybTvZvDBEen4WH6bgfqeQafdRrrboQTSd4gYLFxSNykMD7jGfUEEgj0NbR/V2MnTrUTGTJ5AmeJjmD/mtt/StcCwIYfKR3BE/r/mhPQuoJegnEqGK4EYg+0AzkSMDiRRnWaxlEqPwgGSckZkmfZSD8/nQ0GAXWo7g22VSwDEALglRuPHc5xxwaUzpVSR59onBEc9uOI3Z44966JrNGDDwA20GMHsCDn94pU11ggs4ScbWIWMk8sPeOYz+rIwvfFNsjaN1ucdj6e5B9aw12htvJBKsO8ggjHPGfejeotzgqJIXIEB5XkH1zVBEBB9fz5z+U/YV18NdnPyzgG/kIY7oPoYPzx/4rU+jj9/5ojekNG0cYE4+fzP0rdZ0puN5VwTMckesH0r1eLTzuWkitoembuKYel9Gz5hRjQ9I2qCPSjOg0cniq1y54eZfJVPDVoulgAQKPafpgjirem0YgUWtWRFcPJzM6OL8f9gEaGO1Y/y3tTL8IVh8AVP+Yq/x0fN3Q9Umfir/AKaiWIJBkSwReZJIEjg4ngGn/SdTS/8ADS4Phgk3m2ncFVN4KeUTG1QZ5JIrmL6q1u2qIAgAdlEgn3ZsAye4j0pp6X1HfZNtckLtLYjbKkjHYD7zXCz25C3W7ZRY2ypZ2M/1SR/UBAmTETwPShnXLCHSqqA7be3nmWX+5Gfdqqde1aoWsltpUQFM5XyOPMJk5Mkx3+lfpfUwWvW3I23BCk9iBKz8iKxn6Cj1hgIA5rQepXe7EfasujWEuPsmAMu39h6Ux9Q0HTVtELfC3e07jJ9DtBit0nhsbWgfS9XdYMnHvRfp/XnZwvMkUpPg4o54Hsrd1IVvSeJ71rlZoYvvDot2+6rO0kRmMz9s0jdS8TsBtB4Jz++PlXYk0ii3wPtXA/HSC3rLirxz96lM6yipI8fxReB/Fj0rXc681xSrZoX0/Ti44DuEX1MCnLqXRLKWQ9i7b1IjzgFfiD3UrAPyI+tO1KAm2UfCevKkAkwG49mEd/efvXWRdV7YggCIIPcFcf47+9cR6LdAckZHl+cbs/LE/WulaLVlW2k4IxMfP8wJqfJ0wytRfPU2yRJ2Db3wbeGn2II+k1gbXxCGS5tbbAM/ikL3B8s/KDBzODp6HrIuvuErkkE8mJIz7Z+R9qt/y+xdiY2eVCQR5MwN0fSD6ckZpU+gtdla1ZW5a+FdkOoO2IIPbbK+/A7yRHehFjStabzwe6tBII454PcZyD6RVjqmqezdVmVRIAO4cqeCGUwQRiZPFbLV8uGQlCDBgnhgIJ/ESvY4OZ+Yro4mStFLX9ME7hyB+H1919eOOfnW7o1wKw7QKwv3trbCSIjPcED1HNZ2GG/1nJPr/wCa9bhbzGeN+WpfaGnT3ew4/SivT1zQW1AzRnp7zmtZwRmjFaGKs27lCbepq1avVy1J3RaL5asN9Vnv1h8SlUjuz5O1Hlb61a0XUDbJBkz+IT6DIrXqbzJgHJGZALLzKgxK8do7+tV/gMF3bTtPc4HcYnn6elQPSNup1bMQzGSQAfy/tivbWpIIbuI/LiqRFZpRwBcW6wZiuJJP19aJdM6M1w7oY/ISav8AS+iYRnBKmCY+/wBKdtFqbdtdlq1Lehz+tSfJ+i08X7EbV9IuAjyNnAHf8qY/CHR2sXFe6IZzgHkD/NNqWSg3v+M/lVbRobt0H0pKttYNMJPR3P8A6INc58W+EBqC18TJA45xXRnH+iB3qhpWgQaTcZkcG6j4de0pBDRyCVkfccUHtq1oyp+xwa7t1zSi0d6qGTkj/Z7j2pV6z07S3lLL5X7x6+lUXJ+w/BPtCN4cts138Mhvy5/5+QroXTwNwWchIH1A/uDS/wCGul/6wgSBOTxwftRhNYF1xX+mSh++anb1jyvisCGmsF38gAuwfKeGKGQ09jk/Qmj6WHKOACQB+HEqMArnt/UI4KkfOqLeyZMsh3qREjHGexkcd62a7XqfhXEYLu2kE4PsDnmQfqKWQV2BOpXlv7rbElWBYHaAu8cid3eGJGMj0NCbdtviTthQ22YJKxG0yeQfQ0wdVInzopEF5O6NxlSGiMz/AFYkczyKmntspiGX+gTDdpU+hBCx9feqxWMSlqI2hI5MkD0ncOAQOQePUHmtFtYbj+35Vc1epNtpwQQsAcGfxEHkd8E9/vVsWdzGJnsJkkex7+tepwU2tZ5X5UpdBi1cle/79oopoNRAqv03TAjIqze0oGRVm14eS9CCakVuTUYoXaSrFkUrSCrZc/nM1s/nKq2LYLVf+CtK8RSfkz5v6sFVgAoJO4j5kkE8+2O2Ko3LRCywJjEngTMCfvirfU284yDt2qIzgDJn5yT7mh2oeQB9fyz+dcCPfZXY1la5HzrCs0FEVHRul/CcAS3ymBxx/wAU49LVUUQAPkZ/M81yTousKODNdC0fUNwEEya5qWM7E/ki71vWEABclztA9zWno/WbSOULZBiexNA/EXUCpBXBEx7EiJ+0/ekxtf5iDPPNFRqA6U+n0Fb67bdNsiR3mql/V7UFwfhBAb2nE/euGP1J0Ehm+QNN3hXxQbiHTXB5XBWe/FBw12ZOW8R0+4wZfmP2aTevdNXO3yH1XH3BNFui61mtAGCRjmTQnxG0iZpNHlYyr0O2bc5yQefQZ/UD70J6wSmpFwgQxyZ7wDAjkg/XFakvMjLB5JGfcEZ+9ar+rR7bK44AMQc9xkZUiGIjie8RQXo1jto3N20t8GcC0w52sMCR6HcOcmflIXquqtAANuZEdgCDJDTkT3GCJ9+JFaukdTOnb1Vwp5EsCAJY8MBIyIiVPqa1eImFpybZ8t4m4nBa2Y8w9mEjiDAHvJlCNhbo3U/iyqHaUWW3EMGhio3AjJxHA5HrWxviBX3kMVKx3lAwJ552zzyATOAKXukXGLowXAIt4xJJWCCMN9eJ+tGb/Uf5dgH/AAq7FZBzloyeMNE5kD04Zeivw2gBoQfiA3NBOJ/pCn8axk+n515YtwwAWMkg9/bPpWSXlZwVKhhG0RBgjdA9PNJA9DzW7W2sqZyCcA5juPaJ47138F50cH5HHq0KafUMcnmru/FL2m1m07SQR/btV9+pAV2JHiciafYUsn1rbbcA0HbWluKs239TR+JLQ1Yiau4oJYuVa3mpuSs2cAv6U3HcoJC7SD6g+UH5TAmqHULRCWz2jaf/AHDn8oNNPR0/1btpvhzcRkO0kwxhl80wfOFwPX71OuaVG06XEJ3HczDgRADfUMrH5GvOT7Po3PWilWy2K10S6ZpN+JAJws8EyJGeCOfcU7ER5pAQQadOj3iV745xxQIaVlnaJjuQJx6/444q70np126222SFEbmOFWfX19YqNdnRx9GfULJuTtEy0D78+woLf6LdDkbRiBMgDORk+2ad9RFgIi/0wZ4JAyzEA4McDtun3qze8TWpdEsqRt8xMjcZjaCPwiBM5x2HFBXgLnWK3RvCF2+drSoKsVIBIMAx5hjkdjTR0PwgLFxXL7htgCDIbgn3Hp6ZB4msfDHX2shFgFE7AiRktBBMtBOMdz3NOS6wMyfDUbcCF/qywM9xgc+s0tUwwsE7Q7rV65byROMxjmp1e6T6fv5UW8X6L4d5LyEbW8rR2ImJHyn7UJS0WkmCIwPXP+cfWpHT6tAPULZAngjP/FBm1hUq+7zARng/6igjjnbJ+lMXXSYnsIA95JxH0pW1ADbto4JAkExMx+HJ/wA1WER5KD2k1qFVWMZe2QQTbcDzJwPIwJwRE7T60N6jqBdtiAR3ODhuJIGQD/bvWWgsEhFkSSUkEZkxtnuJPzE5xga9X027aXIgcTJ/C2c+qmPuDExRSWiNto16fUMYky6/hO4GM4OT+tNl+5b+GEuuIADAqQ8EqYUlCQI+f9RxmaSNLYZmhRJ9VzI5yRx3zRzp+q2HjYxyWmRwNrDsuYkD1+QotCpjn082bgTzy47+YEFeBkkEdpJ4btVy9pLkCRuAJHlgyvqNs55x2pbXUv5D8Peglj8MqxVondAIaIPeI7iry9QmAHkGATIMzng5BHP+arxsnyLo3PbUMdpPsPrnmPtW62QefsaoXboPLAknkE/3An7f2qxolYxMx2/5r0uOujxvyY+wvYYCrKgGhJBHFEdGMSaqzgaLtrFWvj1UsZrfFIwo4R0K/wD/AJC3CYVCHJ9kZWIjuTER3mmjX2V/kLLSR8T+ZKg4P9Rx8trAesj1oH4b6KLp85YWsfEJ8vHCjMEz6nAMmO9vxD1Yam8q2Qos2FhYwudqSBjHltqOJ2k9zXlPs+nTxCrsABI4BAJ45BMf/U0c8PJaSbl0kGJWFLL7AgZPrHpHvXmkVTbCh1LOdxQLL7RI8zxAjP5HE4MWtMiIm3YGeCxG54CkjdujbuIkyTiRjuWp9Aldh27btgBLjYYeYxBwSewyexJxI4zjRr/Edu0rW7Q+GAhAyILeYAmJMAj9ZnAoBrurNeaCSLa+VBiSQZ57kE/Se2aXeoXJcwZAkD5TNRUa+y9Xk9FzqfUzcY+ckMIZmwW9yB2mMZ4FVkvx355/Mfaqg07FdwBIHJ9Pn6US6VoPikD++PvVekRU1T6PF1rZ4Ps0EfPa2DTF4c8R3Eedxdm7EzJB3T7nn7n1oL/00boAn5dqI6jw4AuAQcHE/rSU5LRx36dN6H4mW4AL0Zw85IMFlJBzkKfuK39T6fbIm2oCyJI4XduBI9mx84+/LNFZvoCFGDkn8OwqcOSfwkSwnHPyrpvhvqFz8LbTaFpVUn+oIsM0ehbPr8oNc7WFF/Qs+JtG7ozKD5ZJP6n5d/zpCvb7TM4AOIYRuHuCD9Oa7N19Qw2IDbaQVuESkFSZ5IMGQQI5wPVF1fSy5YG2NzEFgDnE+YAHJaRIExkZEVWGStN9gbpur0lxSGVrVwkZNwlScgEKWUGPSZz3o+dD8UBVu72K8MSrb85AaGMwJK/8LWs6EgU7nKt2UqB7iTPB9Rj86p9P1jWAVceXjgfUbuVMYBE88GKZzvgqrPS91DTwDIcXVMHeZbGTtkyPsfnVRb/2BhsTzIDepHtNMF/X2r2nJZ2a5adQrsNrbXJUSwwYJBDRODxgUIe3OY23D64DEZII4yMxwaCCENF1lUKg71MnKxknvyCpBzO7McZqyNcLs78vAZXHLxnzTyRLebnEH2EXLam21zYzBSoZVbaAcjf5lY8xkcEEHHNm1HKCEZJEncU9QSoxj0FPL7EpahpKKY9MSFI8rEZ+kg+1XNPcFswDI/L0+tB9Ho9ieZ1LklgM5HIPmAPryK9GomBE+wnnOIrt430efzw2+xjS+pPat9q8AKUjrduMz6Z/vVmz1KRFdcrTzOTiaHKxfUCa1/8AUF9RSdd6q0QprT/Mt6mnXEJ8WIbaxnYF38oPE4HPCEGPoKsdK05ckJG1WEndBnIDkEyRE4EwN2O1BKu6G4cAsRDKVPp2Pvx24ya8jD6PRkvXrSD4RsqNsswXi4WYbSZYl0yCBIGAQK1dUu3FtANbQAQoYWgrQRhSSMjJiAPmaL6PRfCsrdLQzMMwTCAxKmCF3Mwic5oR1/XuWgncexGSSDwSPTj50jGQL1F8ooBjf7TIkkwcxOTwO+aqaRZYYDSYz7mOxFFm6YZhjLR5mmFBM4B4iQRPopPoKl3QiygYMPiDIkQw4KuFbj1Ew2QY9CAZ/C/TUuuht2H2Ajc274agdyCoJcxI5ycepDp13oWkBUpbBvSFChmJMkQCPU4yZPse6HpvE160i42GGJxsQ7h5uMtPEMDmD2BFzp/im8n/AKFq38UjbvIbydwFUuQvaPUj1iI0Xn+hk8LeHVMtd2m6l0oywJWA0ID2kjHA4o/rejWUUqpaWBPMbivK5ntMj/ukUE0HVriqX2/6inbcUSFDSWn8OUMwIMjGSHmitzUvdi8yNv2wYkIqg7x5MkuVJ+cHiptlMoS+pstv/QTdv8pJJIBLAgrAOfxLI/xWPR+ptbaLwKv2JIkcAQCfMsEfhPoRyKan8Ni5qnRjIZQ9t+SrEDcT3gyH+hHyGdb6GVfTh28zFba95uL8Uk8gFWQrGP8Ad6ij8TO0MNq6t9YZRJgb7cST8MEtDZQiADE5WfWl/X2Eti2/xJG+EZlZnDDLbRuUwOSDnGPYn4P6jYdfh7VWdxNtjPnkyNxO4n8eB/3cRV3XWdy3bTOEtggo1slTbgACVMgjHYiOAOaKRNs5r1WxutMGZrgBabjqybIM7jOfNnHuKUOq3t0DduULC8Y9scetN3iywbW5g5ctJUxgAylxVBAMAngj5zSVrVhvwx349f09qtJKgjb1IXTNbIYqxX5KRJEkevPvtFZWdSXUBWCMAVI+XYGJHy4kUK+JiPU/v9K8tvJgmJnPoYwfvR+JvkGrGsZgwddymGBBgiJVtpHIJjHr6SasdF1ioCjAEzgEYHMk988R7zQnS3yzbWiXXZmYBjy8HALBaz0wJg7tpBAIJMx3EHj60MDo1XtWgZkKw6ztbe0PPu05IPPt61bt6wlBzOR37R3nvS29pmZvPtIJEMTPP6f4otolJWJHy7T6+1PFYydzqek+Mn9TD5ek9ifX2ofrNcB6/Q151ix28i94OJoNqMDaSPoZz967Y56k5HxSwrp+rKOSfvRH/q1r/cKSLjek1hup/wDMr9Cv8SX2eKkmBM0Y6PpV3orofORBMicgbQfU7lEjifeqHS0JvIo5LBfYBjtJM9oJpr6cjW7Rtg3ASQ6EN5G/pc5OGO1uIwoNcDOxF7VdSUWmCefbcU25LKiypgLJH+0ECBG4VQ1VvTO4a3c2Hf57LKx3FQIZCDG8/wC0NM5GMCdRsqyA/FMzHBIBgCWJOUgESBhiJw2R2u6ezEBfxN5j5lIgmAYBiDKgZyZjilGC/QUtt8FWU/DQOfgszh2vBXubMAKZCpk9ses9j8N9E0iIHZbdy83mZyAfMSWMegBY+9ck0HTTb09l7tp0ClwxdgJ3ncDEZEAGQcSRNM/g3oepdjcNwFCSUUOQCs4aBwPQUlb9Dyl99HT9QLRwVQj0IBqnquiaS8pDWUEwZUbTI4yPSlLxXq7+j27ioDfhImMds96A6Xx86YYT7g1LS08ba1M6qOlLiDOOG4OIBx7Y96rjo7LcZ9oZSrDaD28sCMf7RSt0r+IlpiFYwT602W+vrtlWXPrR1E3No8hbGdpAVd0BZJ2qcDuSZiB3j3oPr9Cxt2x8RviJchGyNzBTAK4BBlQV4JQcGKwT+JOkS+9jUObbIQBcYf6bSJBkE7frFHL/AFq01n4k2rtjPxLjEBdsfiAAIbt6U4mtM4+em3Lerc3bZCp/qWTIYTb87TMkEkElyIB3GJgUf0vUWd9u3cAhSSG3s1oscvyQFAbmc4iabdP0nQa1PjaO6q/j89sADe0yxIAO7zGTM59c0A6zZu6XclxLt22QFf4cuoHa405mZLHHeZMGgxk0xe8Sh79hR5dlvzLtWCJgqFkZWBPuSwwQBXLdYjgwxk9z6mul9S1FsAKgFuJaEB2kXBuB3ScEj5QRxNKHVFSCGDiV8neDz3H4Yk4nvxFNDBSFyK3tbaMjPM+s8H09eP7VgRx7cx9p/farwsEKCpBwcRxyfTkQfnNO2IimbZM/THcz+tEHYsZwSTLzwzHkz6fPuTVZLZ3DPIwfQ5Hf0NWtCkHH4h3H7kUGxpQxW9NvAO5ZOSN6SCeZG7M+tWtNYKsdw47SJiPzoLp3uT5mbHBJM/Qn9D6UZ/mVI5gjERjiOe0/b5VLcK5qKfXVDKCRHb9nvSvdKiNyknPfaI9iVM0x9TaUO3tn3kfrQO1fdT+K2e0PbRo+rKdtdMvUctLGCGM1jW7UvJPH0AA+kdq01jBPQXCC5VQW27Qv9RDCNw9/lnNFNFfvBj8QtbQAyrlZaFMKEYSCT3AmJoBYZiIMlTgiceoxV3SWEI3NO0YIGczHAIMR3kDHIoMIQ077HG4qf926QTOJGMQI7gx7123wY2isWVSyysYyxgsx5yf7CuHai/anDQeQDaUAAcEbZMH3nn60Osa4o8qTEzAJA/4pKTfg859n0r1hbd5dpIg898VzXrusHSbyXLLlgZm3++1J48aapcTA7D5YodrurG/cR7oLAEEieaRSyv8Arnp1jqFjW9Z09k/Dt2LaneC5l3MEAwMKuaBa/wDhxrFTyqpcT+FsNzjIwZj15I7CnXwR4s0eoVbSXBbcCNj4P0nn6U53bTASCCKHYvyzw+cL3SNbaP8AqaW7juFn9Kt3erPaULeW6kjAcMs/Kea7s77lZiYVfzPoKBeIvBzdStIpfYFMgMAR8sZoYmP/ADM+etU+59zMSCfNHMUyeEOnW773Lmuvvb0gQkjeVLEEKggY/wCKfuu/wST4YbTXmW4BkNlSf1FIPVdd1Hp6nTX7afD4Ba2GVvk3+ar9YiG69ZrPifWdMZ9NpNYHs5IhUYDdnkgww+1EfA/8VdRoF+E6C+jXN7F2b4m0gAqpOO059/XCDdYEkxHsOKxcDsZp8FPoTxFprepS3qtFbLfEAMbRtXEZB4HAMAnAjvSB4q0oVFa5bPxQ205OeQswZnB59hVPwf8AxQ1ehQWttu7aGAHB3KPZlPHzBpz038R9BqA1rXWRsvEeaNy+0jlanjTHVajjz2yj7SPT7Hg/ai2l3blBVQVU8yAwA80mRESat+MOl2tPrHWwS1okFZO4hTDAT9D9BVK/1EOIj8QywAmMeUHsCYk+33L7Muiam2RK7YzvA55iRM8EQfoK13rJVhkH61hbyoLKIAgHjHyHv3PvWxiWEn5fYY/KlGRctXyBJMgfbPzrdpizAsP2ccVTtWyykMDgf3ohoLflPqBkfv70rKI133LDgycEcZFAjuJ4kjtE/emJVhjmZ45wftQDWhg7ccnODHtVeNkeRFO7cJ/F29orTWTsSZNebacmWbSiNkeZiIyAOeCeB2z7Vf07KimUVmgQCGIYMQAI+Q3SfbBkULsKJkkYzmSD7EAGrt3UO7Fm2FolmAIb0kjA9O3pWCZ39KwLEAkEzJGNvIknuO49qoMI4E/v07fWvTmD3Py9f1rZo1BncYAjsDyQIzgT6nj60DB3U2bYW2CN2+2vmWfLgBoxAb4m/wBeB64FJpN/4FI9NzAyY3bR5RmPnyKY9LqU+GEubEJYEINxJJEecqS27crDG3bsEzMV62nS+2nvKsWnaCFgNZufEAcxnyYRt3o0c0owq2bTPwjGPY49/amHonjjXaQbbd8un+y55wPkTkfeqtxtquTIfdtBaWIMFWAiAJxJHofYVuudBNtBd1DrbD+YW+bh947UG0MtY0Wf4iWNQnw9ZbuoSfxW2O2fXBBFFtFY1ZAfp/UnZeyXGn6ZrmdjpF+d62Lj2/8A2k4+1XNb09dnxLFy5bYcoSykH24NBpGxnZem+Lddp/Lr7Uj/APYgkfUCq/iTrmj1tl03I24RB5n68VyLQeNuoWPKbpuL6XBu/Pmpc8SpccM9gKZmVrOWBYW9d/DPWoA1tVuKRIg5H3oF1Hwvq7Am7p3UesSPyru/hrxCr2knGBTCHt3RBgilXIxnCPlY6VwJKsB7ggfeinRemjV6hLRhAeSBwB+prv3W/CiXrTIpEEcED9iuXeGPD9zS650uLkYU+s96Pz1BmEI2vUW71xEYlVdkBPcKSBWok4UnA9P/ABzVjrwYai6G5DsD9Ca0JewFMYmD/mqfRP7L2mvEMDghQcHg44j/ABkV7ZuwI5Egj1ED1qtatEkwI7/vHFW0skGkZRIKaVeP3g1cCFc8en+Kp6ExRZrflAjt86iy6B1p2zBI+RIpf6uh3GY++frTK2B2nvn7UtdUC/EOPp+zVuM5+UHsPesazYen51rqpI32TjE7hkR2Hcj07VssR6HdzM4IiCM8fP51VDR86zW4eeefkJBE+3r9KxjJgDgGfyx++1WOk3tlwNMLOTBIx6gcjORVEGtlp+Mx274FAw46bXacptezBhVa4GzbSdo+GFMOomCw9pjmiOkv/Cmyu66hVXXMtAJDQ477dxUZn/5EUqDQq+1kcGSd4E7lAA3NtIyImTxAzAq7ZukrIQuwQgXGwMu2YJieZJMQBxFKxi7rrgt6oXbkuoBKSBBhmgCMEA9hwZByCSweD7+nuXGua3zM5wWyB6D2pRvXL7W7YM3bjMYQTcYjkERJ9sGM4ojrNcLdrY9tluf1KRtK/Q0rTHTWYzu+g0+nKgWoA7RXM/4v+Hrko9uGHHlEMSeBA5pO6Z4j1NkbrVwlR2ParQ8e3zeS5e8yqZ2/3oAWoHdZ8B9R0toXntFkiSUO7ZiTuAyAO54oHZ0t5oc2rhX12mP0rvXSPGn8zaYGPhMIkjMEZWjegv2WEKFj0gVnZpn7OA6LU3reV3AfI0W6d4wvWXBJJHoa7nc0NpxBRSPkKQf4geB0NlrthYZRMDuKT0srRf6J42t3ky0N6UL6n19ReW4w4MGuOrqmUypIIp76eRqNOrtkyAR8qLjDKpfgs+Nija28ycM275EgT/n60CWi/iPzam6I/CY/IRQerT4c9ehTSAMB+z96L29P7Vq6NpYWeZj9KNW7UVC67OmJ60raazFE1GK1hfYVatJxSDg3WWjEgY7xSZ1Uj4h+n6V0DVpAxSX1zUMHztyMHaoP/wDQEn71XiIcvgJYEc1jUqVcgQCvST9K9U17v9MYrGNZq/buFji0plTjZGQpkhlgnEmJ/QVUVhInP7594rLY4IKknMhlJ5GZ9VI5zBrGC2kuRJZlRuQQD/pSo2/gUsAeCPT1MzY0uluajbYU27hDBbDLhfO0tgABcKTkA8+ooVrrwuvuJCyFmB5QVQA4USMiODWzp+uNqWtttYZHE+kzGSP+O9KE6N1fS6vw+iXEazde4Cpd1JK9yAJmPrXN+rdcvaq81++2525gACBwABwKcfCPjG0LpvdUL34XbbBG4L6nacUB13Qbup/mNbptMy6QOzCIwvJgdwPbisgAS1qyJAOD2rbb23GAZwg7n0pm6d1fQ39NY0HwBZZ7qm7qWIwoaSQ3MkYzAE0R674Ft372pfprKdPp7ayZ3K1wAllVu8CJ9zW6NrLHh7xPpNJphpwh1B3FyePpJpm6X1s9TRv5Sz8B7cckQZmBiuQdC6RevsPh22Ydz2+9OWssdQ0Sqbc21OIt8j3JpKSKzvo/W+pajSMLeogkiZBkUTfxPaKHeREZmuaafqVkBf567cugMGuMskgH+k96p/xE6ho3+Fc6cWFsgq/4gCe2GyDSKH9Dup+xV8RWUF+41r8BYke2aO+DdQfh7ef9RfkAaAaDaylW5o14f0FwW328nzL814qleYJP/WlDxbYK628Gx5p+kAA/ag1uC3tNdT8d+HjqNPb1VsRcCD4g9cD8+1cqtfioy9QtLGOHSyYozbFA+lcCmTRoMTXPXp1y+jCDmBWVkHvRJrAiqjrFKAr30kfpSd4r0sbW+lOZg0G8R6XfaaOeftmnh4xbWyIlSoKldRyEryvalYB5Xqn0Psff/NeVlbI7z9I/vWCWltBl7LEmT3EDH0gn6/KtbMCP3n8v7961vdntj3P9wATXkxkH+1Ax58+KfbP8RGt6X+TtIAhGyf8AtPNIU1jWzTaO3WvDehOjtXNJe3aliJtbpkf1eXlYoPcu9R0Ng2m+LYsX5lcAPiDnkY+U0Y8JeEbt21/M2rqq4PlU/wCab73QtdrUFzXhTYtA4X8UDlgB7UuhwHdE8SWrtjTaPQLsvgAOXgDjOf6iTmmnS6XU2HKaxlfcJVhx8j6VynxH0mxbZbvT7jFRnk7lI7g8iuh+A/Hi3tFdsamX1ChvM2d4M7fkRxS1P2PNtdA3q/XNPor94XbAvLeTAxAPGZ7Vy29cBwshZwDVzrV93uHeZ9Pah9NKxC29Zv013YQaM9O8SXbbeQLnA9BQCjHh3pjXXBCmB37TWrM7DO70dk8Jahrtj/VAyYI7EVzjx34NfSXvip5rLksDBwTmDA5p98N2nQgNx6U03kW7ba3cUFSII/fHzqKrCtI4p0o4Apq6fZxVPrHhd9Jd3L5rJ/CfT2PoaIdNuDFKyq8CK2scVWv2KK2hVfVW6UAualCtVro3CPvV/Xmh1qaKGOf66zsuOvoT9u1aKOeLtPtuh+zD8xQKuuXq04qWPD2pUqURSVIqVKASVKlSsYlSpUrGLul6lcQQrsPkSKdPD/8AFHV2bfwbirdWIDGQV+cfi/KufVkrEUMRtOgaDwr8Zi+mvAhgWeexOYFCOvdBbRL8UXQGJjaDzS5Y111J2XGWedpI/SsL2oZ8uzMfck0MYdR5euljJ5NYVIqRTANlnkSJronh7q72kAS0p965wKZvCviL+XPnAK/c0lrUU43j7Oo6Lq28AMuxjRBNYT3ik7U9etXwGT6j0NbNJ1bMNx61Avg6XLi3AUaCsQRyKW9d0s6d125tt+E9wedp/wA1YsauR5T+dEBcF1SrnB+49x6UDLow03ArTrKlsfDO1u/4T2P/AJ9qz1GRQCL2rtzQy6pBphvWqFamzyaCGFrxXp91nd3Uz/Y0m10jXWd6Mp7gikH/AKZcrp430c/LPelapUqVUgSpUqUAkqVKlYxKlSpWMSpUqVjEqVKlYx6DWRFYVmhrGR5Xs1DXlYJe6bqyhwcGmvQasMIkfI96SFq/otWUNJU6Ui8Og6YNMqfoOKO6S7tAMZpO6T1AYBJjmmCxqARgz6VBot6MCuLghsj9/atILJgyydiOR8x3qpavxEdv1q7p7wj95oG8NLbWyCCKHapAas63Sz5kYq0/Q/MUNfUuMOv24oYMmYNpZBqh/Kj/AG0Z01wNxirH8r8qZGZxSpUqV1nCSpUqVjEqVKlYxKlSpWMSpUqVjEqVKlYxKlSpWMbK8rxa9NAYk1mjVrqCsbQto9YVpg6d1OM0mqav6duKSpKTR0GxrgYir9nWRzSl0xyYk0TVzB+lRaLLsPremazYA+n1oRo2M/arunbP79KGGLQ0Y5GP7Vt2v7/Yf5rHRHMfL+1W91HAaf/Z"]
        
        list += ["https://www.ecosia.org",
                 "https://www.theguardian.com/email/form/footer/today-uk",
                 "https://uk.reuters.com/",
                 "https://www-nytimes-com.cdn.ampproject.org/v/s/www.nytimes.com/wirecutter/reviews/best-standing-desk/amp/?0p19G=0232&amp_js_v=0.1&usqp=mq331AQHKAFQCrABIA%3D%3D#origin=https%3A%2F%2Fwww.google.com&prerenderSize=1&visibilityState=prerender&paddingTop=32&p2r=0&csi=1&aoh=16025117842518&viewerUrl=https%3A%2F%2Fwww.google.com%2Famp%2Fs%2Fwww.nytimes.com%2Fwirecutter%2Freviews%2Fbest-standing-desk%2Famp%2F%253f0p19G%3D0232&history=1&storage=1&cid=1&cap=navigateTo%2Ccid%2CfullReplaceHistory%2Cfragment%2CreplaceUrl%2CiframeScroll",
                 "data:text/html;charset=utf-8;base64,PGltZyBzcmM9Imh0dHBzOi8vd3d3LmJldDM2NS5jb20vZmF2aWNvbi5pY28iPg==",
                 "file:///Users/some/Downloads/index.html",
                 "https://consent.yahoo.com/v2/collectConsent?sessionId=3_cc-session_d5551c9f-5d07-4428-b0f9-6e92b1c3ca4e"]
        
        list += ["https://consent.youtube.com/m?continue=https%3A%2F%2Fwww.youtube.com%2F&gl=DE&m=0&pc=yt&uxe=23983172&hl=en-GB&src=1"]
        
        list += ["some://www.ecosia.org",
                 "apps://www.theguardian.com/email/form/footer/today-uk",
                 "sms://uk.reuters.com/"]
        
        list += ["about:blank",
                 "about:srcdoc"]
        
        list += ["randomurl.com",
                 "https://aguacate.com",
                 "https://www.hello.com",
                 "http://www.hello.com"]
        
        let urls = list.map {
            URL(string: $0)!
        }
        
        measure {
            urls.forEach {
                _ = protection.policy(for: $0)
            }
        }
    }
}