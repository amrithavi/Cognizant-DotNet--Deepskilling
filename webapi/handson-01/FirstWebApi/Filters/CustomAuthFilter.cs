using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace FirstWebApi.Filters;

public class CustomAuthFilter : ActionFilterAttribute
{
    public override void OnActionExecuting(ActionExecutingContext context)
    {
        if (!context.HttpContext.Request.Headers.ContainsKey("Authorization"))
        {
            context.Result = new BadRequestObjectResult(
                "Invalid request - No Auth token");

            return;
        }

        string? token =
            context.HttpContext.Request.Headers["Authorization"];

        if (string.IsNullOrEmpty(token) ||
            !token.Contains("Bearer"))
        {
            context.Result = new BadRequestObjectResult(
                "Invalid request - Token present but Bearer unavailable");
        }
    }
}