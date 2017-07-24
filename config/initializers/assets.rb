# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( landingpage/core.min.css )
Rails.application.config.assets.precompile += %w( landingpage/thesaas.min.css )
Rails.application.config.assets.precompile += %w( landingpage/style.css )

Rails.application.config.assets.precompile += %w( dashboard/animate.css )
Rails.application.config.assets.precompile += %w( dashboard/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( dashboard/chartist-plugin-tooltip.css )
Rails.application.config.assets.precompile += %w( dashboard/chartist.min.css )
Rails.application.config.assets.precompile += %w( dashboard/default.css )
Rails.application.config.assets.precompile += %w( dashboard/fullcalendar.css )
Rails.application.config.assets.precompile += %w( dashboard/jquery.toast.css )
Rails.application.config.assets.precompile += %w( dashboard/morris.css )
Rails.application.config.assets.precompile += %w( dashboard/sidebar-nav.min.css )
Rails.application.config.assets.precompile += %w( dashboard/style.css )
Rails.application.config.assets.precompile += %w( dashboard/spinners.css)
Rails.application.config.assets.precompile += %w( dashboard/materialdesignicons.min.css )
Rails.application.config.assets.precompile += %w( dashboard/bootstrap.css )
Rails.application.config.assets.precompile += %w( dashboard/card.css )
Rails.application.config.assets.precompile += %w( dashboard/custom.css )
Rails.application.config.assets.precompile += %w( dashboard/home.css )

Rails.application.config.assets.precompile += %w( dashboard/bootstrap-wysihtml5.css )
Rails.application.config.assets.precompile += %w( dashboard/dropzone.css )

Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( sidebar-nav.min.js )
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( waves.js )
Rails.application.config.assets.precompile += %w( custom.min.js )
Rails.application.config.assets.precompile += %w( jquery.slimscroll.js )

Rails.application.config.assets.precompile += %w( card.css )
Rails.application.config.assets.precompile += %w( card.js )
Rails.application.config.assets.precompile += %w( stripe.js)

