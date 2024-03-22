# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nbardavi <nbabardavid@gmail.com>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/03/15 11:21:29 by bvan-pae          #+#    #+#              #
#    Updated: 2024/03/22 15:59:57 by nbardavi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CPP     := g++
CXXFLAGS  := -Wall -Wextra -Werror -std=c++17 -g
NAME    := mmm
OBJDIR  := objs
SRCDIR	:= srcs
SRC := $(wildcard $(SRCDIR)/*.cpp)
OBJ := $(SRC:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

GREEN   := \033[38;2;4;231;98m
BLUE    := \033[38;2;119;166;182m
RED     := \033[0;31m
RESET   := \033[0m

.PHONY: all clean fclean re

all: $(NAME)

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(OBJDIR)
	@echo "$(BLUE)Compiling $<...$(RESET)"
	@$(CPP) $(CXXFLAGS) -c $< -o $@
	@echo "$(GREEN)Compiled $< successfully!$(RESET)"

$(NAME): $(OBJ)
	@echo "$(GREEN)Linking...$(RESET)"
	@$(CPP) $(CXXFLAGS) $(OBJ) -o $(NAME)
	@echo "$(GREEN)Compilation successful!$(RESET)"

clean:
	@echo "$(RED)Cleaning up object files and dependencies...$(RESET)"
	@rm -rf $(OBJDIR)
	@echo "$(RED)Cleaned.$(RESET)"

fclean: clean
	@echo "$(RED)Removing executable $(NAME)...$(RESET)"
	@rm -f $(NAME)
	@echo "$(RED)Removed.$(RESET)"

re: fclean all
