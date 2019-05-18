Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper
{
   public enum Style : int
   {
       Tile, Center, Stretch, NoChange
   }
   public class Setter {
      public const int SetDesktopWallpaper = 20;
      public const int UpdateIniFile = 0x01;
      public const int SendWinIniChange = 0x02;
      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);

      public static void SetWallpaper (string path ) {
         SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
         RegistryKey key = Registry.CurrentUser.OpenSubKey(@"Control Panel\Desktop", true);
         key.SetValue(@"WallpaperStyle", "2") ;
         key.SetValue(@"TileWallpaper", "0") ;
         key.Close();
      }
   }
}
"@

$WallpaperRemoteFile = "https://github.com/hugsy/modern.ie-vagrant/raw/master/scripts/wallpaper.jpg"
$WallpaperLocalFile = $ENV:HOMEDRIVE + "" + $ENV:HOMEPATH + "\wallpaper.jpg"
(New-Object System.Net.WebClient).DownloadFile($WallpaperRemoteFile, $WallpaperLocalFile)
Write-Output "[+] Copied wallpaper to '$WallPaperLocalFile'"
[Wallpaper.Setter]::SetWallpaper($WallPaperLocalFile)
Write-Output "[+] Applied wallpaper"