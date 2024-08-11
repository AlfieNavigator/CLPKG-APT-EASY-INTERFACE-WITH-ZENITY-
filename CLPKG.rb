#!/usr/bin/env ruby

require 'open3'

def listar_programas
  programas = ["Brave", "Firefox", "Chromium", "VLC", "GIMP", "LibreOffice", "Thunderbird", "Audacity"]
  seleccion = `zenity --list --title="CLPKG INSTALL" --column="Programas" #{programas.join(' ')}`
  seleccion.strip
end

def instalar_programa(programa)
  programa = programa.upcase
  case programa
  when "BRAVE"
    system("sudo apt install -y brave-browser")
  when "FIREFOX"
    system("sudo apt install -y firefox")
  when "CHROMIUM"
    system("sudo apt install -y chromium-browser")
  when "VLC"
    system("sudo apt install -y vlc")
  when "GIMP"
    system("sudo apt install -y gimp")
  when "LIBREOFFICE"
    system("sudo apt install -y libreoffice")
  when "THUNDERBIRD"
    system("sudo apt install -y thunderbird")
  when "AUDACITY"
    system("sudo apt install -y audacity")
  else
    system("zenity --error --text='Programa no reconocido. Por favor, elige entre BRAVE, FIREFOX, CHROMIUM, VLC, GIMP, LIBREOFFICE, THUNDERBIRD o AUDACITY.'")
    exit 1
  end

  if $?.success?
    system("zenity --info --text='#{programa.capitalize} se ha instalado correctamente.'")
  else
    system("zenity --error --text='Hubo un error al instalar #{programa.capitalize}.'")
  end
end

if ARGV[0] == "-I" && !ARGV[1].nil?
  system("sudo apt update")
  instalar_programa(ARGV[1])
else
  programa = listar_programas
  if !programa.empty?
    system("sudo apt update")
    instalar_programa(programa)
  else
    system("zenity --error --text='No se seleccionó ningún programa.'")
  end
end

