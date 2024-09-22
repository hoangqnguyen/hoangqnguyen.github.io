HUGO_CONTENT_DIR = content/posts
NOTEBOOKS_DIR = notebooks
HUGO_STATIC_DIR = static

convert:
	@echo "Converting Jupyter notebooks to Markdown..."
	jupyter nbconvert --to markdown $(NOTEBOOKS_DIR)/*.ipynb

move:
	@echo "Ensuring directories exist and moving files..."
	mkdir -p $(HUGO_CONTENT_DIR) $(HUGO_STATIC_DIR)
	@for notebook in $(NOTEBOOKS_DIR)/*.ipynb; do \
		name=$$(basename $$notebook .ipynb); \
		mv $(NOTEBOOKS_DIR)/$$name.md $(HUGO_CONTENT_DIR)/$$name.md; \
		mv $(NOTEBOOKS_DIR)/$$name'_files' $(HUGO_STATIC_DIR)/ 2>/dev/null || true; \
		rm -rf $(NOTEBOOKS_DIR)/$$name'_files' \
		echo "Cleaning up front matter in $$name.md..."; \
		bash cleanup.sh $(HUGO_CONTENT_DIR)/$$name.md; \
		sed -i '' 's#\([a-zA-Z0-9_-]*_files/\)#/\1#g' $(HUGO_CONTENT_DIR)/$$name.md; \
	done

build: convert move
	@echo "Process complete. Notebooks and images have been moved."
