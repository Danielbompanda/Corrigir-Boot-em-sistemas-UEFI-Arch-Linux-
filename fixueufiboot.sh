#!/bin/bash
set -e

EFI_MOUNT="/boot/efi"
ARCH_GRUB_PATH="$EFI_MOUNT/EFI/arch/grubx64.efi"
FALLBACK_DIR="$EFI_MOUNT/EFI/BOOT"
FALLBACK_EFI="$FALLBACK_DIR/BOOTX64.EFI"

echo "=== Script para configurar fallback UEFI para GRUB no Arch Linux ==="

if ! mountpoint -q "$EFI_MOUNT"; then
    echo "ERRO: A partição EFI não está montada em $EFI_MOUNT."
    echo "Por favor, monte a partição EFI antes de continuar."
    exit 1
fi

if [ ! -f "$ARCH_GRUB_PATH" ]; then
    echo "ERRO: Arquivo $ARCH_GRUB_PATH não encontrado."
    echo "Verifique se o GRUB foi instalado corretamente e se o caminho está correto."
    exit 1
fi

echo "Criando diretório de fallback em $FALLBACK_DIR..."
mkdir -p "$FALLBACK_DIR"

echo "Copiando $ARCH_GRUB_PATH para $FALLBACK_EFI..."
cp "$ARCH_GRUB_PATH" "$FALLBACK_EFI"

echo "Configuração de fallback UEFI concluída com sucesso!"
echo "Agora seu firmware Samsung deve reconhecer o bootloader normalmente."
