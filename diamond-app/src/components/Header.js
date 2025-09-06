import React from 'react';
import { 
  AppBar, 
  Toolbar, 
  Typography, 
  Button, 
  Box,
  Container,
  useMediaQuery,
  IconButton,
  Menu,
  MenuItem,
  useTheme,
  Tooltip
} from '@mui/material';
import MenuIcon from '@mui/icons-material/Menu';
import DiamondIcon from '@mui/icons-material/Diamond';
import GitHubIcon from '@mui/icons-material/GitHub';
import { Link as RouterLink } from 'react-router-dom';

const Header = () => {
  const theme = useTheme();
  const isMobile = useMediaQuery(theme.breakpoints.down('md'));
  const [anchorEl, setAnchorEl] = React.useState(null);
  
  const handleMenu = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  return (
    <AppBar position="static" elevation={0} sx={{ backgroundColor: 'white', color: 'primary.main' }}>
      <Container maxWidth="lg">
        <Toolbar disableGutters>
          <DiamondIcon sx={{ mr: 1, color: 'primary.main' }} />
          <Typography
            variant="h6"
            noWrap
            component={RouterLink}
            to="/"
            sx={{
              mr: 2,
              fontWeight: 700,
              color: 'inherit',
              textDecoration: 'none',
              flexGrow: { xs: 1, md: 0 }
            }}
          >
            Diamond Price Estimator
          </Typography>

          {isMobile ? (
            <Box>
              <IconButton
                size="large"
                edge="end"
                color="inherit"
                aria-label="menu"
                onClick={handleMenu}
              >
                <MenuIcon />
              </IconButton>
              <Menu
                id="menu-appbar"
                anchorEl={anchorEl}
                anchorOrigin={{
                  vertical: 'top',
                  horizontal: 'right',
                }}
                keepMounted
                transformOrigin={{
                  vertical: 'top',
                  horizontal: 'right',
                }}
                open={Boolean(anchorEl)}
                onClose={handleClose}
              >
                <MenuItem 
                  component={RouterLink} 
                  to="/" 
                  onClick={handleClose}
                >
                  Estimator
                </MenuItem>
                <MenuItem 
                  component={RouterLink} 
                  to="/learn" 
                  onClick={handleClose}
                >
                  Learn
                </MenuItem>
                <MenuItem 
                  component={RouterLink} 
                  to="/about" 
                  onClick={handleClose}
                >
                  About
                </MenuItem>
                <MenuItem 
                  component="a" 
                  href="https://github.com/Arjunmehta312/Stats-Project-Sem4"
                  target="_blank"
                  rel="noopener noreferrer"
                  onClick={handleClose}
                >
                  <GitHubIcon fontSize="small" sx={{ mr: 1 }} />
                  GitHub
                </MenuItem>
              </Menu>
            </Box>
          ) : (
            <Box sx={{ flexGrow: 1, display: 'flex', justifyContent: 'flex-end', alignItems: 'center' }}>
              <Button 
                component={RouterLink} 
                to="/" 
                color="inherit"
                sx={{ mx: 1 }}
              >
                Estimator
              </Button>
              <Button 
                component={RouterLink} 
                to="/learn" 
                color="inherit"
                sx={{ mx: 1 }}
              >
                Learn
              </Button>
              <Button 
                component={RouterLink} 
                to="/about" 
                color="inherit"
                sx={{ mx: 1 }}
              >
                About
              </Button>
              <Tooltip title="View source code">
                <IconButton
                  color="inherit"
                  component="a"
                  href="https://github.com/Arjunmehta312/Stats-Project-Sem4"
                  target="_blank"
                  rel="noopener noreferrer"
                  sx={{ ml: 1 }}
                >
                  <GitHubIcon />
                </IconButton>
              </Tooltip>
            </Box>
          )}
        </Toolbar>
      </Container>
    </AppBar>
  );
};

export default Header; 