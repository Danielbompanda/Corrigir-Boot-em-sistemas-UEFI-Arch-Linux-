# Corrigir-Boot-em-sistemas-UEFI-Arch-Linux-
Passo a passo de como corrigir erro de grub inbootavel no arch linux

Tutorial: Garantindo Boot do Arch Linux em UEFI Problemático (Samsung)

Este guia é voltado para sistemas UEFI com firmware problemático (como em notebooks Samsung) que não detectam corretamente entradas personalizadas de boot do Arch Linux.

Sintoma

Mesmo com o GRUB instalado corretamente (e entradas visíveis no efibootmgr), o sistema não aparece como opção de boot ou não inicia.

Solução

Usar o caminho UEFI de fallback padrão, que todos firmwares devem reconhecer:
EFI/BOOT/BOOTX64.EFI

Passos Finais da Instalação (Após instalar GRUB)

1. Instale o GRUB normalmente:



grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch

2. Gere o grub.cfg:



grub-mkconfig -o /boot/grub/grub.cfg

3. Crie a pasta de fallback e copie o GRUB EFI para lá:



mkdir -p /boot/efi/EFI/BOOT
cp /boot/efi/EFI/arch/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI

4. Verifique com efibootmgr:



efibootmgr -v

Resultado

Seu notebook agora vai conseguir iniciar o Arch Linux normalmente via UEFI, mesmo com firmware que ignora entradas de boot personalizadas.


---

Opcional: Tornar isso automático com script

Crie um script chamado fixuefiboot.sh:

#!/bin/bash
set -e
mkdir -p /boot/efi/EFI/BOOT
cp /boot/efi/EFI/arch/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI
echo "EFI fallback configurado com sucesso."

Torne executável:

chmod +x fixuefiboot.sh

E execute após instalar o GRUB.


---

Se quiser, posso gerar um PDF ou HTML bonitinho com isso.

