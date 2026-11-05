"""Renders the Play Store graphics (store/out/) with headless Chrome.

Usage: python3 store/render.py <folder with raw phone screenshots>

Raw screenshots are full-screen phone captures (1080 x 2220, from
`adb exec-out screencap -p`); status and navigation bars are cropped away.
"""

import pathlib
import subprocess
import sys
import tempfile

CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
ROOT = pathlib.Path(__file__).resolve().parent
OUT = ROOT / "out"
ICON = ROOT.parent / "app_icon.png"

SHOTS = [
    ("01-dashboard.png", "All your aquariums, at a glance", "Tanks, volumes and overdue tasks on one dashboard"),
    ("07-chat.png", "Ask Aqua AI about your tank", "Advice based on your own readings, livestock and history"),
    ("03-tank-hero.png", "A health check for every tank", "An AI health score and the reasons behind it"),
    ("05-report-plan.png", "Know exactly what to do next", "Step-by-step action plans, prioritised for you"),
    ("02-dashboard-lower.png", "Never miss a water change", "Reminders and one-tap logging built in"),
    ("06-tank-grid.png", "Fish, plants, gear and logs", "Everything about each tank, neatly organised"),
]

# Phone capture geometry (Galaxy S9: 1080 x 2220)
SRC_W, SRC_H, STATUS_BAR, NAV_BAR = 1080, 2220, 72, 144

FONTS = (
    '<link rel="preconnect" href="https://fonts.googleapis.com">'
    '<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600'
    '&family=Sora:wght@600;700&display=block" rel="stylesheet">'
)

OCEAN = """
  background:
    radial-gradient(circle at 85% 8%, rgba(20,224,192,.35), transparent 40%),
    radial-gradient(circle at 5% 45%, rgba(59,130,246,.30), transparent 45%),
    linear-gradient(180deg, #0B1B36 0%, #07122A 45%, #040A16 100%);
"""

GRADIENT_TEXT = """
  background: linear-gradient(120deg, #14E0C0, #22D3EE 55%, #8B5CF6);
  -webkit-background-clip: text; background-clip: text; color: transparent;
"""


def screenshot_html(image: pathlib.Path, title: str, subtitle: str) -> str:
    frame_w = 740
    scale = frame_w / SRC_W
    visible_h = round((SRC_H - STATUS_BAR - NAV_BAR) * scale)
    return f"""<!doctype html><html><head><meta charset="utf-8">{FONTS}<style>
  html, body {{ margin: 0; width: 1080px; height: 1920px; overflow: hidden; }}
  body {{ {OCEAN} font-family: Inter, sans-serif; color: #E8F4FF; }}
  .caption {{ padding: 112px 80px 0; text-align: center; }}
  h1 {{ font: 700 68px/1.12 Sora, sans-serif; margin: 0 0 20px; text-wrap: balance; {GRADIENT_TEXT} }}
  p {{ font-size: 32px; line-height: 1.35; margin: 0; color: #8FA8C8; text-wrap: balance; }}
  .frame {{
    position: absolute; left: {(1080 - frame_w) // 2}px; top: 420px;
    width: {frame_w}px; height: {visible_h}px; overflow: hidden;
    border-radius: 48px; border: 2px solid rgba(156,201,255,.28);
    box-shadow: 0 40px 120px -20px rgba(34,211,238,.35), 0 0 0 10px rgba(255,255,255,.04);
  }}
  .frame img {{ width: {frame_w}px; margin-top: -{round(STATUS_BAR * scale)}px; display: block; }}
</style></head><body>
  <div class="caption"><h1>{title}</h1><p>{subtitle}</p></div>
  <div class="frame"><img src="{image.as_uri()}"></div>
</body></html>"""


def feature_html(image: pathlib.Path) -> str:
    phone_w = 300
    scale = phone_w / SRC_W
    return f"""<!doctype html><html><head><meta charset="utf-8">{FONTS}<style>
  html, body {{ margin: 0; width: 1024px; height: 500px; overflow: hidden; }}
  body {{ {OCEAN} font-family: Inter, sans-serif; color: #E8F4FF; position: relative; }}
  .left {{ position: absolute; left: 72px; top: 0; bottom: 0; width: 560px;
    display: flex; flex-direction: column; justify-content: center; }}
  .brand {{ display: flex; align-items: center; gap: 22px; margin-bottom: 22px; }}
  .brand img {{ width: 96px; height: 96px; border-radius: 26px; background: #fff; padding: 8px;
    box-sizing: border-box; box-shadow: 0 0 40px rgba(34,211,238,.45); }}
  h1 {{ font: 700 78px/1 Sora, sans-serif; margin: 0; {GRADIENT_TEXT} }}
  p {{ font-size: 28px; margin: 0 0 26px; color: #B9D3EE; }}
  .pills {{ display: flex; gap: 10px; flex-wrap: wrap; }}
  .pill {{ font-size: 18px; font-weight: 600; padding: 8px 16px; border-radius: 999px;
    color: #E8F4FF; background: rgba(143,184,255,.12); border: 1px solid rgba(156,201,255,.3); }}
  .phone {{ position: absolute; right: 70px; top: 46px; width: {phone_w}px; height: 600px;
    overflow: hidden; border-radius: 34px; transform: rotate(-6deg);
    border: 2px solid rgba(156,201,255,.3);
    box-shadow: 0 30px 80px -10px rgba(34,211,238,.4); }}
  .phone img {{ width: {phone_w}px; margin-top: -{round(STATUS_BAR * scale)}px; display: block; }}
</style></head><body>
  <div class="left">
    <div class="brand"><img src="{ICON.as_uri()}"><h1>AquaLog</h1></div>
    <p>Smarter care for healthier aquariums.</p>
    <div class="pills"><span class="pill">✨ AI assistant</span><span class="pill">💧 Water tracking</span><span class="pill">⏰ Reminders</span></div>
  </div>
  <div class="phone"><img src="{image.as_uri()}"></div>
</body></html>"""


def icon_html() -> str:
    # Full-bleed white square; Play applies its own rounded mask, so the art
    # is inset to keep the droplet clear of the corners
    return f"""<!doctype html><html><head><meta charset="utf-8"><style>
  html, body {{ margin: 0; width: 512px; height: 512px; background: #fff; }}
  img {{ position: absolute; left: 51px; top: 51px; width: 410px; height: 410px; }}
</style></head><body><img src="{ICON.as_uri()}"></body></html>"""


def render(html: str, out: pathlib.Path, width: int, height: int) -> None:
    with tempfile.NamedTemporaryFile("w", suffix=".html", delete=False) as page:
        page.write(html)
    subprocess.run(
        [
            CHROME, "--headless=new", "--disable-gpu", "--hide-scrollbars",
            "--force-device-scale-factor=1", "--allow-file-access-from-files",
            f"--window-size={width},{height}", "--virtual-time-budget=8000",
            f"--screenshot={out}", pathlib.Path(page.name).as_uri(),
        ],
        check=True, capture_output=True,
    )
    print(f"wrote {out.relative_to(ROOT.parent)}")


def main() -> None:
    raw = pathlib.Path(sys.argv[1]).resolve()
    OUT.mkdir(exist_ok=True)
    render(icon_html(), OUT / "icon-512.png", 512, 512)
    render(feature_html(raw / "01-dashboard.png"), OUT / "feature-graphic.png", 1024, 500)
    for i, (name, title, subtitle) in enumerate(SHOTS, start=1):
        render(screenshot_html(raw / name, title, subtitle), OUT / f"screenshot-{i}.png", 1080, 1920)


if __name__ == "__main__":
    main()
