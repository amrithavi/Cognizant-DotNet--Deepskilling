using Microsoft.AspNetCore.Mvc;
using MicroservicesJwtDemo.Models;
using MicroservicesJwtDemo.Services;

namespace MicroservicesJwtDemo.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly TokenService _tokenService;

    public AuthController(TokenService tokenService)
    {
        _tokenService = tokenService;
    }

    [HttpPost("login")]
    public IActionResult Login([FromBody] LoginModel model)
    {
        if (IsValidUser(model))
        {
            var role = model.Username == "admin" ? "Admin" : "User";
            var token = _tokenService.GenerateToken(model.Username, role);
            return Ok(new { Token = token });
        }
        return Unauthorized();
    }

    private bool IsValidUser(LoginModel model)
    {
        // Hardcoded check for demo purposes only
        return model.Username == "admin" && model.Password == "admin123"
            || model.Username == "user" && model.Password == "user123";
    }
}