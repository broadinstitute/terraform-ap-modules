# Workspace Manager

This module creates the service account and CloudSQL databases necessary for 
running the [Workspace Manager](http://github.com/databiosphere/terra-workspace-manager).
This currently requires two postgres databases: one for the workspace manager 
itself, and one for the Stairway library used for managing sagas.