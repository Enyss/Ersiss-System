using System;
using System.Collections.Generic;
using System.Linq;
using Godot;

namespace ErsissSystem.Core.Attributes
{
    using UnderlyingType = UInt64;

    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
    public class ExportFlagsEnumAttribute : ExportAttribute
    {
        public ExportFlagsEnumAttribute(Type enumType)
            : base(PropertyHint.Flags, GetFlagsEnumHintString(enumType))
        { }

        private static string GetFlagsEnumHintString(Type enumType)
        {
            Dictionary<UnderlyingType, List<string>> flagNamesByFlag = new Dictionary<UnderlyingType, List<string>>();
            UnderlyingType flag = (UnderlyingType)1;
            foreach (string name in Enum.GetNames(enumType))
            {
                UnderlyingType value = (UnderlyingType)Convert.ChangeType(Enum.Parse(enumType, name), typeof(UnderlyingType));
                while (value > flag)
                {
                    if (!flagNamesByFlag.ContainsKey(flag))
                    {
                        flagNamesByFlag.Add(flag, new List<string>());
                    }
                    flag <<= 1;
                }
                if (value == flag)
                {
                    if (!flagNamesByFlag.TryGetValue(flag, out List<string> names))
                    {
                        names = new List<string>();
                        flagNamesByFlag.Add(flag, names);
                    }
                    names.Add(name);
                }
            }
            return string.Join(", ", flagNamesByFlag.Values.Select(flagNames => string.Join(" / ", flagNames)));
        }
    }
}