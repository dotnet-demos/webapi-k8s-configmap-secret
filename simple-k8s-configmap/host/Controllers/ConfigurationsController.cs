using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace SimpleK8sHosting.Controllers
{
    [ApiController]
    public class ConfigurationsController : ControllerBase
    {
        private IConfigurationRoot ConfigRoot;
        public ConfigurationsController(IConfiguration config)
        {
            ConfigRoot = config as IConfigurationRoot;
        }
        [HttpGet]
        [Route("[controller]/{key}")]
        public string Get(string key)
        {
            return $" {key}: {ConfigRoot[key]}";
        }
    }
}
