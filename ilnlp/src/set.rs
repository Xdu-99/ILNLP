use std::fmt::Display;
use std::hash::{Hash, Hasher};

/// a set of elements
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub struct Set<T> {
    inner: Vec<T>,
}

impl<T: Ord + Clone> FromIterator<T> for Set<T> {
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        Set::new(iter.into_iter().collect())
    }
}


impl<T: Ord + Clone> Set<T> {
    pub fn new(data: Vec<T>) -> Set<T> {
        let mut set = Set { inner: data };
        set.rebuild();
        set
    }

    pub fn is_empty(&self) -> bool {
        self.inner.is_empty()
    }
    fn rebuild(&mut self) {
        self.inner.sort();
        self.inner.dedup();
    }
    ///  Union: self ∪ other
    pub fn union(&self, other: &Set<T>) -> Set<T> {
        let mut result = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < self.inner.len() && j < other.inner.len() {
            match self.inner[i].cmp(&other.inner[j]) {
                std::cmp::Ordering::Less => {
                    result.push(self.inner[i].clone());
                    i += 1;
                }
                std::cmp::Ordering::Equal => {
                    result.push(self.inner[i].clone());
                    i += 1;
                    j += 1;
                }
                std::cmp::Ordering::Greater => {
                    result.push(other.inner[j].clone());
                    j += 1;
                }
            }
        }

        while i < self.inner.len() {
            result.push(self.inner[i].clone());
            i += 1;
        }
        while j < other.inner.len() {
            result.push(other.inner[j].clone());
            j += 1;
        }

        Set::new(result)
    }

    /// Intersection : self ∩ other
    pub fn intersection(&self, other: &Set<T>) -> Set<T> {
        let mut result = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < self.inner.len() && j < other.inner.len() {
            match self.inner[i].cmp(&other.inner[j]) {
                std::cmp::Ordering::Less => i += 1,
                std::cmp::Ordering::Equal => {
                    result.push(self.inner[i].clone());
                    i += 1;
                    j += 1;
                }
                std::cmp::Ordering::Greater => j += 1,
            }
        }

        Set::new(result)
    }

    /// Difference: self - other
    pub fn difference(&self, other: &Set<T>) -> Set<T> {
        let mut result = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < self.inner.len() && j < other.inner.len() {
            match self.inner[i].cmp(&other.inner[j]) {
                std::cmp::Ordering::Less => {
                    result.push(self.inner[i].clone());
                    i += 1;
                }
                std::cmp::Ordering::Equal => {
                    i += 1;
                    j += 1;
                }
                std::cmp::Ordering::Greater => j += 1,
            }
        }

        while i < self.inner.len() {
            result.push(self.inner[i].clone());
            i += 1;
        }

        Set::new(result)
    }

    pub fn is_subset(&self, other: &Set<T>) -> bool {
        if self.len() > other.len() {
            return false;
        }
        let mut i = 0; 
        let mut j = 0;

        while i < self.len() && j < other.len() {
            match self.inner[i].cmp(&other.inner[j]) {
                std::cmp::Ordering::Equal => {
                    i += 1;
                    j += 1;
                }
                std::cmp::Ordering::Less => {
                    // a[i] < b[j]，a[i] 在 b 中不存在
                    return false;
                }
                std::cmp::Ordering::Greater => {
                    // a[i] > b[j]，继续在 b 中寻找
                    j += 1;
                }
            }
        }

        // 如果 a 中还有元素未匹配，则不是子集
        i == self.inner.len()
    }

    pub fn is_superset(&self, other: &Set<T>) -> bool
    {
        other.is_subset(self)
    }

    /// self ∩ other = ∅
    pub fn is_disjoint(&self, other: &Set<T>) -> bool
    {
        let mut i = 0;
        let mut j = 0;

        while i < self.inner.len() && j < other.inner.len() {
            match self.inner[i].cmp(&other.inner[j]) {
                std::cmp::Ordering::Less => i += 1,
                std::cmp::Ordering::Equal => return false,
                std::cmp::Ordering::Greater => j += 1,
            }
        }

        true
    }

    pub fn contains(&self, term: &T) -> bool {
        self.inner.contains(term)
    }

    pub fn len(&self) -> usize {
        self.inner.len()
    }
    pub fn insert(&mut self, term: T) {
        self.inner.push(term);
    }
    pub fn iter(&self) -> std::slice::Iter<T> {
        self.inner.iter()
    }
}

impl<T:Clone+ToString> Display for Set<T> {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        if self.inner.is_empty() {
            write!(f, "{{}}")
        } else {
            let inner_str = self
                .inner
                .iter()
                .map(|t| t.to_string())
                .collect::<Vec<_>>()
                .join(", ");
            write!(f, "{{{}}}", inner_str)
        }
    }
}

impl<T:Ord+Hash+Clone> Hash for Set<T> {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.inner.iter().for_each(|term| {
            term.hash(state);
        });
    }
}
