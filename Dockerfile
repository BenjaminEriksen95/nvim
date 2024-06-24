# Use an official Python image as a base
FROM python:3.12-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    neovim \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install the neovim Python package
RUN pip install neovim

# Create a non-root user
RUN useradd -ms /bin/bash user

# Switch to the non-root user
USER user
WORKDIR /home/user

# Set up Neovim configuration (optional)
RUN mkdir -p ~/.config/nvim
#COPY init.vim ~/.config/nvim/init.vim

# Set the default command to nvim
CMD ["nvim"]
