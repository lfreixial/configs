.PHONY: all up zsh tmux nvim update-zsh update-tmux update-nvim install-deps \
        _deps-linux _deps-mac _deps-common

OS := $(shell uname -s)

all: up

up: install-deps zsh tmux nvim
	@echo ""
	@echo "Done! Open a new terminal or run: source ~/.zshrc"

install-deps:
	@echo "==> Installing dependencies..."
	@if [ "$(OS)" = "Linux" ]; then \
		$(MAKE) --no-print-directory _deps-linux; \
	elif [ "$(OS)" = "Darwin" ]; then \
		$(MAKE) --no-print-directory _deps-mac; \
	else \
		echo "  Unknown OS: $(OS), skipping system packages"; \
	fi
	@$(MAKE) --no-print-directory _deps-common

_deps-linux:
	@echo "  [Linux] Checking system packages..."
	@missing=""; \
	for pkg in git curl ca-certificates tmux bat fd-find ripgrep zsh zsh-syntax-highlighting fontconfig unzip jq shellcheck shfmt chafa; do \
		dpkg -s "$$pkg" >/dev/null 2>&1 || missing="$$missing $$pkg"; \
	done; \
	if [ -n "$$missing" ]; then \
		sudo apt-get update -qq && sudo apt-get install -y $$missing; \
	fi
	@mkdir -p "$$HOME/.local/bin"
	@command -v fd >/dev/null 2>&1 || { command -v fdfind >/dev/null 2>&1 && ln -sf "$$(command -v fdfind)" "$$HOME/.local/bin/fd"; }
	@command -v zoxide >/dev/null 2>&1 || curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
	@command -v eza >/dev/null 2>&1 || { \
		ARCH=$$(uname -m); \
		curl -sSL "https://github.com/eza-community/eza/releases/latest/download/eza_$${ARCH}-unknown-linux-musl.tar.gz" -o /tmp/eza.tar.gz 2>/dev/null && \
		tar -xf /tmp/eza.tar.gz -C /tmp eza && \
		sudo mv /tmp/eza /usr/local/bin/eza && \
		rm -f /tmp/eza.tar.gz && \
		echo "  eza installed"; \
	}
	@command -v nvim >/dev/null 2>&1 || { \
		ARCH=$$(uname -m); \
		case "$$ARCH" in aarch64) ARCH=arm64 ;; esac; \
		curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$${ARCH}.tar.gz" && \
		sudo rm -rf /opt/nvim && \
		sudo tar -C /opt -xzf "nvim-linux-$${ARCH}.tar.gz" && \
		sudo ln -sf "/opt/nvim-linux-$${ARCH}/bin/nvim" /usr/local/bin/nvim && \
		rm -f "nvim-linux-$${ARCH}.tar.gz" && \
		echo "  neovim installed"; \
	}
	@command -v rbenv >/dev/null 2>&1 || curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
	@command -v lazygit >/dev/null 2>&1 || { \
		VERSION=$$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | sed -n 's/.*\"tag_name\": \"v\([^\"]*\)\".*/\1/p'); \
		ARCH=$$(uname -m); \
		case "$$ARCH" in x86_64) ARCH=x86_64 ;; aarch64) ARCH=arm64 ;; armv7l) ARCH=armv7 ;; esac; \
		curl -sSL "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$${VERSION}_Linux_$${ARCH}.tar.gz" -o /tmp/lazygit.tar.gz && \
		tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit && \
		sudo mv /tmp/lazygit /usr/local/bin/lazygit && \
		rm -f /tmp/lazygit.tar.gz && \
		echo "  lazygit installed"; \
	}
	@fc-list | grep -qi "JetBrainsMono" || { \
		echo "  Installing JetBrainsMono Nerd Font..."; \
		mkdir -p "$$HOME/.local/share/fonts"; \
		curl -sSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz" -o /tmp/JetBrainsMono.tar.xz; \
		tar -xf /tmp/JetBrainsMono.tar.xz -C "$$HOME/.local/share/fonts"; \
		fc-cache -fv >/dev/null 2>&1; \
		rm -f /tmp/JetBrainsMono.tar.xz; \
		echo "  JetBrainsMono Nerd Font installed"; \
	}

_deps-mac:
	@echo "  [macOS] Checking Homebrew..."
	@command -v brew >/dev/null 2>&1 || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@command -v tmux >/dev/null 2>&1 || brew install tmux
	@command -v eza >/dev/null 2>&1 || brew install eza
	@command -v bat >/dev/null 2>&1 || brew install bat
	@command -v chafa >/dev/null 2>&1 || brew install chafa
	@command -v fd >/dev/null 2>&1 || brew install fd
	@command -v rg >/dev/null 2>&1 || brew install ripgrep
	@command -v jq >/dev/null 2>&1 || brew install jq
	@command -v zoxide >/dev/null 2>&1 || brew install zoxide
	@command -v rbenv >/dev/null 2>&1 || brew install rbenv
	@command -v nvim >/dev/null 2>&1 || brew install neovim
	@command -v starship >/dev/null 2>&1 || brew install starship
	@command -v lazygit >/dev/null 2>&1 || brew install lazygit
	@ls "$$HOME/Library/Fonts/"*JetBrains* >/dev/null 2>&1 || { \
		echo "  Installing JetBrainsMono Nerd Font..."; \
		mkdir -p "$$HOME/Library/Fonts"; \
		curl -sSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz" -o /tmp/JetBrainsMono.tar.xz; \
		tar -xf /tmp/JetBrainsMono.tar.xz -C "$$HOME/Library/Fonts"; \
		rm -f /tmp/JetBrainsMono.tar.xz; \
		echo "  JetBrainsMono Nerd Font installed"; \
	}

_deps-common:
	@echo "  [common] Checking cross-platform tools..."
	@[ -d "$$HOME/.oh-my-zsh" ] || sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	@command -v starship >/dev/null 2>&1 || curl -sS https://starship.rs/install.sh | sh -s -- -y
	@[ -d "$$HOME/.fzf" ] || (git clone --depth 1 https://github.com/junegunn/fzf.git "$$HOME/.fzf" && "$$HOME/.fzf/install" --all)
	@[ -d "$$HOME/.tmux/plugins/tpm" ] || git clone https://github.com/tmux-plugins/tpm "$$HOME/.tmux/plugins/tpm"

zsh:
	@echo "==> Deploying zsh config..."
	@for file in zsh/.[!.]*; do \
		base=$$(basename "$$file"); \
		if [ -f "$$HOME/$$base" ]; then \
			mv "$$HOME/$$base" "$$HOME/$$base.bak"; \
			echo "  Backed up ~/$$base"; \
		fi; \
		cp "$$file" "$$HOME/$$base"; \
		echo "  Copied $$base"; \
	done

update-zsh:
	@echo "==> Pulling zsh config from home directory..."
	@for file in zsh/.[!.]*; do \
		base=$$(basename "$$file"); \
		if [ -f "$$HOME/$$base" ]; then \
			cp -v "$$HOME/$$base" "$$file"; \
		fi; \
	done

tmux:
	@echo "==> Deploying tmux config..."
	@if [ -f "$$HOME/.tmux.conf" ]; then \
		mv "$$HOME/.tmux.conf" "$$HOME/.tmux.conf.bak"; \
		echo "  Backed up ~/.tmux.conf"; \
	fi
	@printf "  Enter your city for the weather widget (press Enter to skip): "; \
	read city; \
	if [ -n "$$city" ]; then \
		sed "s/Your City/$$city/g" tmux/.tmux.conf > "$$HOME/.tmux.conf"; \
		echo "  .tmux.conf deployed (city: $$city)"; \
	else \
		cp tmux/.tmux.conf "$$HOME/.tmux.conf"; \
		echo "  .tmux.conf deployed (edit @dracula-fixed-location in ~/.tmux.conf to set your city later)"; \
	fi
	@if [ -d "$$HOME/.tmux/plugins/tpm" ]; then \
		"$$HOME/.tmux/plugins/tpm/bin/install_plugins" && echo "  TPM plugins installed"; \
	else \
		echo "  TPM not found, skipping plugin install"; \
	fi

update-tmux:
	@cp "$$HOME/.tmux.conf" tmux/.tmux.conf
	@echo "==> tmux config updated from home directory"

nvim:
	@echo "==> Deploying neovim config..."
	@mkdir -p "$$HOME/.config/nvim"
	@cp -r neovim/. "$$HOME/.config/nvim/"
	@echo "  Neovim config deployed to ~/.config/nvim"

update-nvim:
	@mkdir -p neovim
	@cp -a "$$HOME/.config/nvim/." neovim/
	@echo "==> Neovim config updated from ~/.config/nvim"
